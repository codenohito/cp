class MoneyRecordsController < ApplicationController
  before_action :authenticate_user!, :check_user_is_able_to_see_money

  def index
    @records = MoneyRecord.ordered
  end

  def create
    permitted_params = money_record_params
    permitted_params[:kind] = permitted_params[:kind] == '1'
    @record = MoneyRecord.new(permitted_params)

    unless @record.save
      flash[:alert] = @record.errors.full_messages.join '; '
    end
    redirect_to action: :index
  end

  private

  def money_record_params
    params.require(:money_record).permit(
      :moment, :amount, :kind,
      :category_id, :nakama_id, :project_id,
      :comment)
  end

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
