class User < ActiveRecord::Base
  validates :auth_token,  presence: true
  validates :email,       presence: true
  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :gender,      presence: true
  validates :locale,      presence: true
  validates :birthday,    presence: true
end
