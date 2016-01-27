class User < ActiveRecord::Base
  has_one :auth_token
  has_and_belongs_to_many :movies
  has_many :identities
end
