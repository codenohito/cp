class MoneyRecord < ApplicationRecord
  belongs_to :category, class_name: 'MoneyRecordCategory', inverse_of: :records
  belongs_to :nakama, inverse_of: :money_records
  belongs_to :project, inverse_of: :money_records

  KIND_CONSUMPTION = false
  KIND_INCOME = true

  validates :moment, :amount, :category, presence: true
  validates :kind, inclusion: [true, false]

  scope :ordered, -> { order(moment: :desc) }

  after_initialize :set_default_moment

  private

  def set_default_moment
    if moment.nil?
      self.moment = Time.now
    end
  end
end
