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

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:cluster_id, :name, :descr)
  end
end
