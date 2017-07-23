class Project < ApplicationRecord
  has_and_belongs_to_many :clients
  has_many :history_records

  scope :ordered, -> { order(updated_at: :desc) }
end
