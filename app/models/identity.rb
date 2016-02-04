class Identity < ActiveRecord::Base
  has_secure_password

  attr_accessor :password, :password_confirmation
  validates :password, length: (1..32), confirmation: true, if: :setting_password?

  def self.from_google_oauth2(auth)
    identity = Identity.where(uid: auth["uid"], provider: "google_plus").first_or_initialize do |i|
      i.email = auth["info"]["email"]
    end
    identity.save validate: false
    identity
  end

  def password=(password_str)
    @password = password_str
    self.password_salt   = BCrypt::Engine.generate_salt
    self.password_digest = BCrypt::Engine.hash_secret(password_str, password_salt)
  end

  def authenticate(password)
    password.present? && password_digest.present? && password_digest == BCrypt::Engine.hash_secret(password, password_salt)
  end

  private

  def setting_password?
    self.password || self.password_confirmation
  end
end
