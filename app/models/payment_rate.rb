class PaymentRate < ApplicationRecord
  belongs_to :nakama, inverse_of: :payment_rates
  belongs_to :project, optional: true

  validates :hour_rate, :hour_cost, :active_from, presence: true

  after_initialize :set_defaults

  scope :ordered, -> { order(active_from: :desc) }

  private

  def set_defaults
    self.active_from = Time.now if self.active_from.nil?
  end
end
