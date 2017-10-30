class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.ordered

    respond_to do |format|
      format.html # index.html.erb
      format.json do
        projs_for_json = @projects.select(:id, :name, :cluster_id).
                                   includes(:cluster).
                                   map do |prj|
                                     { id: prj.id, title: prj.title }
                                   end
        render json: {
          projects: projs_for_json
        }
      end
    end
  end

  def show
    @project = Project.find params[:id]
    @history_records = @project.cluster.history_records.ordered
  end

  def money_result
    @project = Project.find params[:id]
    if current_user.moneyman?
      @result = {
        cost: 0.0,
        add_wastes: @project.additional_wastes.to_f,
        wastes: 0.0,
        income: @project.plan_income.to_f,
        profit: 0.0,
        profit_perc: 0.0
      }

      @nakamas_data = Nakama.ordered.includes(:payment_rates).collect do |nakama|
        cost = nil
        nakama.payment_rates.each do |pr|
          next if pr.project && pr.project != @project
          if pr.project == @project
            cost = pr.hour_cost
            break
          else
            cost = pr.hour_cost if cost.nil?
          end
        end
        cost = 0.0 if cost.nil?

        amount = TimeRecord.where(project: @project, nakama: nakama).sum(:amount)
        sum = amount > 0 ? (cost / 60.0 * amount) : 0.0
        @result[:cost] += sum
        { nakama: nakama, cost: cost, amount: amount, sum: sum }
      end

      @result[:wastes] = @result[:cost] + @result[:add_wastes]
      @result[:profit] = @result[:income] - @result[:wastes]
      unless @result[:income] == 0
        @result[:profit_perc] = @result[:profit] / (@result[:income] / 100)
      end
    else
      respond_to do |format|
        format.html do
          flash[:alert] = 'Access denied'
          redirect_to @project
        end
        format.json do
          render json: { error: 'Access denied' }, status: :unauthorized
        end
      end
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_create_params)

    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def update
    @project = Project.find(params[:id])

    @project.update(project_update_params)
    redirect_to @project
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    redirect_to projects_path
  end

  private

  def project_create_params
    params.require(:project).permit(:cluster_id, :name, :descr)
  end

  def project_update_params
    params.require(:project).permit(:time_estim, :plan_income, :additional_wastes)
  end
end
