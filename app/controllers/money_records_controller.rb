class MoneyRecordsController < ApplicationController

  def index
    @records = MoneyRecord.ordered
  end

  def create
    @record = MoneyRecord.new(money_record_params)

    @record.save
    redirect_to action: :index
  end

  private

  def money_record_params
      params.require(:money_record).permit(
        :moment, :amount, :kind,
        :account_id, :category_id,
        :nakama_id, :project_id,
        :comment)
    end

end
