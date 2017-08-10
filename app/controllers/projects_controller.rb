class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.ordered
  end

  def show
    @project = Project.find params[:id]
    @history_records = @project.history_records.ordered
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
    params.require(:project).permit(:name, :descr)
  end
end
