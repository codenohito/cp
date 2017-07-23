class TimeRecord < ApplicationRecord
  belongs_to :nakama, inverse_of: :time_records
  belongs_to :project, inverse_of: :time_records

  scope :ordered, -> { order(theday: :desc, id: :desc) }

  validates :theday, :amount, :nakama, :project, presence: true

  after_initialize :set_default_theday

  private

  def set_default_theday
    if theday.nil?
      self.theday = Date.today
    end
  end
end
