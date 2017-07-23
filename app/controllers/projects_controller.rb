class ProjectsController < ApplicationController

  def index
    @projects = Project.ordered
  end

  def show
    @project = Project.find params[:id]
    @history_records = @project.history_records.ordered
  end

end
