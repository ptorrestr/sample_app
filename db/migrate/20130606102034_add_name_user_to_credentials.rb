class AddNameUserToCredentials < ActiveRecord::Migration
  def change
    add_column :credentials, :name_user, :string
  end
end
