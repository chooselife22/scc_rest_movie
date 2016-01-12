class User < ActiveRecord::Base
  has_one :auth_token
  has_and_belongs_to_many :movies

  def self.from_google_oauth2(auth)
    user = User.where(google_uid: auth["uid"]).first_or_create do |u|
      u.name = auth["info"]["name"]
      u.email = auth["info"]["email"]
    end
    user
  end
end
