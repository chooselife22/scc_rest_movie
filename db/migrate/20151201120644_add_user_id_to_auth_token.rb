class AddUserIdToAuthToken < ActiveRecord::Migration
  def change
    add_column :auth_tokens, :user_id, :integer
  end
end
