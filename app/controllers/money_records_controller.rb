class MoneyRecordsController < ApplicationController

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

end
