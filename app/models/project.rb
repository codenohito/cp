class Project < ApplicationRecord
  belongs_to :cluster, inverse_of: :projects
  has_many :money_records, inverse_of: :project, dependent: :nullify
  has_many :time_records, inverse_of: :project, dependent: :destroy
  has_many :timers, inverse_of: :project, dependent: :nullify

  scope :ordered, -> { order(updated_at: :desc) }

  validates :name, presence: true

  def title; "#{cluster.name} #{name}" end
end
