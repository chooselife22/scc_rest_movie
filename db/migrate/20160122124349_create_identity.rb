class CreateIdentity < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :uid
      t.string :email
      t.string :password_digest
    end
  end
end
