class Timer < ApplicationRecord
  belongs_to :user, inverse_of: :timers
  belongs_to :project, inverse_of: :timers, optional: true

  default_scope { order(created_at: :asc) }
end
