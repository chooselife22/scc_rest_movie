require 'securerandom'
class AuthToken < ActiveRecord::Base
  before_create :generate_auth_token

  private

  def generate_auth_token
    self.token = SecureRandom.hex
  end
end
