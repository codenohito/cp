class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    if current_user.admin?
      @nakamas = Nakama.order(id: :asc)
    else
      @nakamas = [current_nakama]
    end
  end
end
