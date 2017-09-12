class TimeRecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @nakamas = current_user.admin? ? Nakama.order(id: :asc).to_a : [current_nakama]
    @projects = Project.ordered
    today = Date.today
    @from_day = today.beginning_of_month
    @to_day = today.end_of_month
  end

  def weekly_report
    the_day_in_the_week = Date.today
    @nakamas = current_user.admin? ? Nakama.order(id: :asc).to_a : [current_nakama]
    @projects = Project.ordered
    if params[:weeks_before].present?
      the_day_in_the_week = the_day_in_the_week - params[:weeks_before].to_i.weeks
    end
    @week_start = the_day_in_the_week.beginning_of_week
  end

  def create
    @record = TimeRecord.new(time_record_params)
    unless current_user.admin?
      @record.nakama = current_nakama
    end

    success = @record.save

    ActionsLogger.add 'create', @record, current_user if success

    respond_to do |format|
      format.html do
        unless success
          flash[:alert] = 'Record is not created'
        end
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
  end

  def edit
    @record = TimeRecord.find params[:id]
    unless current_user.admin?
      if @record.nakama != current_nakama
        raise ActiveRecord::RecordNotFound, "Record not found"
      end
    end
  end

  def update
    @record = TimeRecord.find params[:id]

    prm_params = time_record_params
    unless current_user.admin?
      prm_params[:nakama_id] = current_nakama ? current_nakama.id : nil
    end

    if @record.update(prm_params)
      ActionsLogger.add 'update', @record, current_user
      redirect_to timers_path
    else
      render 'edit'
    end
  end

  def destroy
    @record = TimeRecord.find params[:id]
    unless current_user.admin?
      if @record.nakama != current_nakama
        raise ActiveRecord::RecordNotFound, "Record not found"
      end
    end
    @record.destroy
    ActionsLogger.add 'destroy', @record, current_user
    redirect_to timers_path
  end

  private

  def time_record_params
    params.require(:time_record).permit(:theday, :amount, :nakama_id,
                                        :project_id, :comment)
  end
end
