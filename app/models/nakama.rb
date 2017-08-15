class Nakama < ApplicationRecord
	has_one :user, inverse_of: :nakama, dependent: :nullify

  has_many :time_records, inverse_of: :nakama, dependent: :destroy

  validates :name, presence: true
end
