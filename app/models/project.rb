class Project < ApplicationRecord
  has_many :history_records, inverse_of: :project, dependent: :destroy
  has_many :money_records, inverse_of: :project, dependent: :nullify
  has_many :time_records, inverse_of: :project, dependent: :destroy

  scope :ordered, -> { order(updated_at: :desc) }

  validates :name, presence: true
end
