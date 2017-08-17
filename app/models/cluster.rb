class Cluster < ApplicationRecord
  has_many :history_records, inverse_of: :cluster, dependent: :destroy
  has_many :projects, inverse_of: :cluster, dependent: :destroy
end
