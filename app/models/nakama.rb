class Nakama < ApplicationRecord
	has_one :user, inverse_of: :nakama, dependent: :nullify

  has_many :payment_rates, inverse_of: :nakama, dependent: :destroy

  has_many :time_records, inverse_of: :nakama, dependent: :destroy

  validates :name, presence: true

  scope :ordered, -> { order(id: :asc) }
end
