class RemovePasswordDigestAndGoogleUidFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :google_uid
    remove_column :users, :password_digest
  end
end
