class User < ActiveRecord::Base
  has_one :auth_token
  has_secure_password
  has_and_belongs_to_many :movies
end
