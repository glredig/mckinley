class AuthProvider < ActiveRecord::Base
  validates :type,              presence: true
  validates :user_id,           presence: true
  validates :provider_user_id,  presence: true
  validates :token,             presence: true
  validates :expiration,        presence: true
  validates :link,              presence: true
  validates :verified,          presence: true
end
