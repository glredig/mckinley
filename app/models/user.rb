class User < ActiveRecord::Base
  has_one :facebook, dependent: :destroy

  validates :auth_token,  presence: true, uniqueness: true
  validates :email,       presence: true
  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :gender,      presence: true
  validates :locale,      presence: true
  validates :birthday,    presence: true

  include Authentication
end
