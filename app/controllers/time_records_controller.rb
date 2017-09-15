class TimeRecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @avl_nakamas = Nakama.accessible_by(current_ability, :read).ordered
    @avl_projects = Project.accessible_by(current_ability, :read).ordered

    today = Date.today
    @filter = {
      from_day: today.beginning_of_month,
      to_day: today.end_of_month,
      project_ids: [],
      nakama_ids: []
    }
  end

  def weekly_report
    the_day_in_the_week = Date.today
    @nakamas = Nakama.accessible_by(current_ability, :read).ordered
    @projects = Project.accessible_by(current_ability, :read).ordered
    if params[:weeks_before].present?
      the_day_in_the_week = the_day_in_the_week - params[:weeks_before].to_i.weeks
    end
    @week_start = the_day_in_the_week.beginning_of_week
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
end
