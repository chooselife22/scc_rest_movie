require 'securerandom'
class AuthToken < ActiveRecord::Base
  before_create :generate_auth_token

  def valid_token?
    self.expire_at > Time.now - 1.minutes
  end

  private

  def generate_auth_token
    self.token = SecureRandom.hex
  end

end
