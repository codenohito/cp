class HistoryRecord < ApplicationRecord
  belongs_to :project

  scope :ordered, -> { order(moment: :desc) }
end
