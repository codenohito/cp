class TimeRecord < ApplicationRecord
  belongs_to :nakama
  belongs_to :project

  after_initialize :set_default_theday

  scope :ordered, -> { order(theday: :desc, id: :desc) }

  private

  def set_default_theday
    if theday.nil?
      self.theday = Date.today
    end
  end
end
