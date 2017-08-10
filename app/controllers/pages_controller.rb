class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @projects = Project.ordered
  end
end
