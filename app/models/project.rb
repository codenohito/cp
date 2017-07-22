class Project < ApplicationRecord
  belongs_to :client

  scope :ordered, -> { order(updated_at: :desc) }
end
