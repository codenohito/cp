class MoneyRecordCategory < ApplicationRecord
  has_many :records, class_name: 'MoneyRecord',
                     inverse_of: :category,
                     dependent: :restrict_with_exception

  validates :name, presence: true
end
