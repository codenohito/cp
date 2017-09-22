class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @nakamas = Nakama.accessible_by(current_ability, :read).ordered
  end
end
