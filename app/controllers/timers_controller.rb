class TimersController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery except: [:update, :destroy, :create]

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json do
        records = TimeRecord.accessible_by(current_ability, :read).ordered.limit(12)
        timers = current_user.timers

        render json: {
          records: records,
          timers: timers.map { |timer| timer_json_data(timer) },
          isAdmin: current_user.admin?,
          nakama: Nakama.accessible_by(current_ability, :read).collect,
          nakamaId: current_user.nakama_id
        }
      end
    end
  end

  def create
    if can? :create, Timer
      timer = Timer.new user: current_user
      timer.assign_attributes(timer_params)
      timer.started_at = Time.now
      timer.save
      render json: { timer: timer_json_data(timer) }
    else
      render json: { error: 'access denied' }, status: :unprocessable_entity
    end
  end

  def update
    timer = Timer.find params[:id]
    if can? :update, timer
      if params[:act] == 'play'
        if timer.started_at.nil?
          timer.started_at = Time.now
          timer.save
        end
      elsif params[:act] == 'pause'
        if timer.started_at.present?
          timer.seconds = timer.seconds.to_i + (Time.now - timer.started_at).to_i
          timer.started_at = nil
          timer.save
        end
      else
        timer.update(timer_params)
      end
      render json: { timer: timer_json_data(timer) }
    else
      render json: { error: 'access denied' }, status: :unprocessable_entity
    end
  end

  def destroy
    timer = Timer.find params[:id]
    if can? :destroy, timer
      return_data = timer_json_data timer, 'finished'
      timer.destroy

      respond_to do |format|
        format.html do
          redirect_to timers_path
        end
        format.json do
          render json: { timer: return_data }
        end
      end
    else
      respond_to do |format|
        format.html do
          flash[:alert] = "Access denied"
          redirect_to timers_path
        end
        format.json do
          render json: { error: 'access denied' }, status: :unprocessable_entity
        end
      end
    end
  end

  private

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
