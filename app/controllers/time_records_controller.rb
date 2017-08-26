class TimeRecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @records = TimeRecord.ordered
    unless current_user.admin?
      @records = @records.where(nakama: current_nakama)
    end
    @timers = current_user.timers

    respond_to do |format|
      format.html # index.html.erb
      format.json do
        render json: {
          records: @records,
          timers: @timers.map { |timer| timer_json_data(timer) }
        }
      end
    end
  end

  def create
    @record = TimeRecord.new(time_record_params)
    unless current_user.admin?
      @record.nakama = current_nakama
    end

    success = @record.save

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

  def timer_run
    if params[:id].blank? || params[:id] == 'new'
      timer = Timer.new user: current_user
    else
      timer = current_user.timers.find params[:id]
    end
    timer.started_at = Time.now if timer.started_at.nil?
    timer.assign_attributes(timer_params) if params[:timer].present?
    timer.save

    render json: { timer: timer_json_data(timer) }
  end

  def timer_pause
    timer = current_user.timers.find params[:id]
    unless timer.started_at.nil?
      timer.seconds = timer.seconds.to_i + (Time.now - timer.started_at).to_i
      timer.started_at = nil
      timer.save
    end
    render json: { timer: timer_json_data(timer) }
  end

  def timer_finish
    timer = current_user.timers.find params[:id]
    return_data = timer_json_data timer, 'finished'
    timer.destroy
    render json: { timer: return_data }
  end

  def report
    if current_user.admin?
      @nakamas = Nakama.order(id: :asc)
      @projects = Project.ordered
      today = Date.today
      @from_day = today.beginning_of_month
      @to_day = today.end_of_month
    else
      flash[:alert] = 'No access'
      redirect_to root_url
    end
  end

  private

  def time_record_params
    params.require(:time_record).permit(:theday, :amount, :nakama_id,
                                        :project_id, :comment)
  end

  def timer_params
    params.require(:timer).permit(:project_id, :comment)
  end

  def timer_json_data(timer, state = nil)
    seconds_passed = timer.seconds.to_i
    seconds_passed += (Time.now - timer.started_at).to_i unless timer.started_at.nil?
    {
      id: timer.id,
      nakama_id: timer.user.nakama_id,
      state: state ? state : (timer.started_at.nil? ? 'paused' : 'running'),
      minutes: seconds_passed / 60,
      seconds: seconds_passed % 60,
      project_id: timer.project_id,
      comment: timer.comment
    }
  end
end
