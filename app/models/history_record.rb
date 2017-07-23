class HistoryRecord < ApplicationRecord
  belongs_to :project, inverse_of: :history_records

  validates :project, :moment, presence: true

  scope :ordered, -> { order(moment: :desc) }

  after_initialize :set_default_moment

  private

  def set_default_moment
    self.moment = Time.now if moment.nil?
  end
end
