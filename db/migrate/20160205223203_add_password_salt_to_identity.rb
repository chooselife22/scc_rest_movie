class AddPasswordSaltToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :password_salt, :string
  end
end
