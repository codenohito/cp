class MoneyRecord < ApplicationRecord
  belongs_to :account, class_name: 'MoneyAccount'
  belongs_to :category, class_name: 'MoneyRecordCategory'

  belongs_to :nakama
  belongs_to :project

  KIND_CONSUMPTION = 0
  KIND_INCOME = 1

  after_initialize :set_default_moment

  scope :ordered, -> { order(moment: :desc) }

  private

  def set_default_moment
    if moment.nil?
      self.moment = Time.now
    end
  end
end
