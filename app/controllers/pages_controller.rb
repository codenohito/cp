class PagesController < ApplicationController

  def dashboard
    @projects = Project.ordered
  end

end
