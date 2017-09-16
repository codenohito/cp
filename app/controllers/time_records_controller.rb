class TimeRecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    build_base_report_with_filter

    # = = = Filter = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    @filter[:from_day] = nil
    @filter[:to_day] = nil
    today = Date.today

    if params[:from_day].present?
      begin
        @filter[:from_day] = Date.parse(params[:from_day])
      rescue
        # do nothing
      end
    end
    @filter[:from_day] = today.beginning_of_month if @filter[:from_day].nil?

    if params[:to_day].present?
      begin
        @filter[:to_day] = Date.parse(params[:to_day])
      rescue
        # do nothing
      end
    end
    @filter[:to_day] = today.end_of_month if @filter[:to_day].nil?

    @filter[:to_day] = @filter[:from_day] if @filter[:to_day] < @filter[:from_day]

    # = = = Data = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    @records = @records.
      where('time_records.theday >= ? AND time_records.theday <= ?',
            @filter[:from_day],
            @filter[:to_day])

    @sums_by_nakama_projects = []
    @avl_nakamas.each { |nkm| @sums_by_nakama_projects[nkm.id] = [] }
    @records.each do |record|
      csum = @sums_by_nakama_projects[record.nakama_id][record.project_id] || 0
      @sums_by_nakama_projects[record.nakama_id][record.project_id] = csum + record.amount
    end
  end

  def weekly_report
    build_base_report_with_filter

    # = = = Filter = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    the_day_in_the_week = Date.today
    @filter[:weeks_before] = 0

    if params[:weeks_before].present?
      @filter[:weeks_before] = params[:weeks_before]
      the_day_in_the_week = the_day_in_the_week - params[:weeks_before].to_i.weeks
    end

    @week_start = the_day_in_the_week.beginning_of_week

    # = = = Data = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    @records = @records.where('theday >= ? AND theday <= ?',
                              @week_start,
                              @week_start + 6.days)

    @sums_by_nakamas = []
    @avl_nakamas.each { |nkm| @sums_by_nakamas[nkm.id] = 0 }

    @weekly_report_data = []

    @records.each do |record|
      @sums_by_nakamas[record.nakama_id] += record.amount
      unless @weekly_report_data[record.project_id]
        @weekly_report_data[record.project_id] = {}
      end
      daystr = record.theday.strftime "%Y%m%d"
      unless @weekly_report_data[record.project_id][daystr]
        @weekly_report_data[record.project_id][daystr] = []
      end
      if @weekly_report_data[record.project_id][daystr][record.nakama_id]
        @weekly_report_data[record.project_id][daystr][record.nakama_id] += record.amount
      else
        @weekly_report_data[record.project_id][daystr][record.nakama_id] = record.amount
      end
    end
  end

  def create
    @record = TimeRecord.new(time_record_params)
    @record.nakama = current_nakama if cannot? :change_nakama, @record

    if can? :create, @record
      success = @record.save

      ActionsLogger.add 'create', @record, current_user if success

      respond_to do |format|
        format.html do
          flash[:alert] = 'Record is not created' unless success
          redirect_to action: :index
        end
        format.json do
          if success
            render json: { success: true, record_id: @record.id }
          else
            render json: { success: false, errors: @record.errors.messages }
          end
        end
      end
    else
      respond_to do |format|
        validate_with_abilities
        format.html do
          er_msgs = @record.errors[:access].join('. ')
          flash[:alert] = "Access denied" + (er_msgs.present? ? ": #{er_msgs}" : '')
          redirect_to action: :index
        end
        format.json do
          render json: { success: false, errors: @record.errors.messages }
        end
      end
    end
  end

  def edit
    @record = TimeRecord.find params[:id]
    authorize! :read, @record
  end

  def update
    @record = TimeRecord.find params[:id]
    if can? :update, @record
      prm_params = time_record_params
      prm_params.delete :nakama_id if cannot? :change_nakama, @record

      if @record.update(prm_params)
        ActionsLogger.add 'update', @record, current_user
        redirect_to timers_path
      else
        render 'edit'
      end
    else
      validate_with_abilities
      er_msgs = @record.errors[:access].join('. ')
      flash[:alert] = "Access denied" + (er_msgs.present? ? ": #{er_msgs}" : '')
      redirect_to timers_path
    end
  end

  def destroy
    @record = TimeRecord.find params[:id]
    if can? :destroy, @record
      @record.destroy
      ActionsLogger.add 'destroy', @record, current_user
    else
      validate_with_abilities
      er_msgs = @record.errors[:access].join('. ')
      flash[:alert] = "Access denied" + (er_msgs.present? ? ": #{er_msgs}" : '')
    end
    redirect_to timers_path
  end

  private

  def time_record_params
    params.require(:time_record).permit(:theday, :amount, :nakama_id,
                                        :project_id, :comment)
  end

  def validate_with_abilities
    if cannot?(:work_with_expired, @record) && (@record.theday <= Date.today - 1.week)
      @record.errors[:access] << 'You cannot manage time records older than week'
    end
  end

  def build_base_report_with_filter
    @avl_nakamas = Nakama.accessible_by(current_ability, :read).ordered
    @avl_projects = Project.accessible_by(current_ability, :read).ordered

    # = = = Filter = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    @filter = { nakama_ids: [], project_ids: [] }
    @filter[:project_ids] = params[:project_ids] if params[:project_ids].present?
    @filter[:nakama_ids] = params[:nakama_ids] if params[:nakama_ids].present?

    # = = = Data = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    rec_nkms = @avl_nakamas.map { |nkm| nkm.id.to_s }
    rec_nkms = rec_nkms & @filter[:nakama_ids] if @filter[:nakama_ids].any?
    rec_prjs = @avl_projects.map { |prj| prj.id.to_s }
    rec_prjs = rec_prjs & @filter[:project_ids] if @filter[:project_ids].any?
    @records = TimeRecord.includes(:project, :nakama).
      where(nakama_id: rec_nkms).
      where(project_id: rec_prjs).
      ordered
  end
end
