class MoneyRecordsController < ApplicationController
  before_action :authenticate_user!, :check_user_is_able_to_see_money

  def index
    @records =[]
  end

  private

  def check_user_is_able_to_see_money
    unless current_user.moneyman?
      respond_to do |format|
        format.html do
          flash[:alert] = 'Access denied'
          redirect_to root_url
        end
        format.json do
          render json: { error: 'Access denied' }, status: :unauthorized
        end
      end
    end
  end
end
