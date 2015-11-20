require 'securerandom'
class AuthToken < ActiveRecord::Base
  before_create :generate_auth_token

  def valid_token?
    self.expired_at > Time.now
  end

  def extend_auth_token
    self.expired_at =  Time.now + 10.minutes
    self.save!
  end

  private

  def generate_auth_token
    self.expired_at = Time.now + 10.minutes
    self.token = SecureRandom.hex
  end
end
