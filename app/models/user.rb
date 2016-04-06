class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :device_token, presence: true, uniqueness: true
end