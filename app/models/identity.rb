class Identity < ActiveRecord::Base
  belongs_to :user
  has_secure_password

  def self.from_google_oauth2(auth)
    identity = Identity.where(uid: auth["uid"], provider: "google_plus").first_or_create do |i|
      i.name = auth["info"]["name"]
      i.email = auth["info"]["email"]
    end
    identity
  end
end
