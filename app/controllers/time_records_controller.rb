class TimeRecordsController < ApplicationController

  def index
    @records = TimeRecord.ordered
  end

  def create
    @record = TimeRecord.new(time_record_params)

    @record.save
    redirect_to action: :index
  end

  private

  def time_record_params
      params.require(:time_record).permit(:theday, :amount, :nakama_id,
                                          :project_id, :comment)
    end

end
