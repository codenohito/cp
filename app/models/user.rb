class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :recoverable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  belongs_to :nakama, optional: true

  has_many :timers, inverse_of: :user, dependent: :destroy

  ## Permissions stores in 'perms' integer field where:
  #   0 bit: admin — have all permissions in every projects
  #   1 bit: ability to read and manage money records out of projects
  #   2 bit: ability to read money records at all (needs special permissions in projects)
  def admin?;       perms && perms[0] == 1 end
  def moneymaster?; perms && perms[1] == 1 || admin? end
  def moneyman?;    perms && perms[2] == 1 || moneymaster? end
end

# Projects
#  subprojects

# Estimation
#  - by members
#  - in hours

# Every member has
#   - conditio


# - access project
#   - members list
#     - read list
#     - read conditions
#     - read estimation
#     - write list
#     - write conditions
#     - write estimation
#   - history records
#     - read
#     - write
#   - time records
#     - read owned
#     - write owned
#     - read any
#     - write any
#   - money records
#     - read
#     - write
