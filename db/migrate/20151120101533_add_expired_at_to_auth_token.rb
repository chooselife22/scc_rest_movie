class AddExpiredAtToAuthToken < ActiveRecord::Migration
  def change
    add_column :auth_tokens, :expired_at, :datetime
  end
end
