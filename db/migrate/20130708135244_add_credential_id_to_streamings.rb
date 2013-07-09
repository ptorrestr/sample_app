class AddCredentialIdToStreamings < ActiveRecord::Migration
  def change
    add_column :streamings, :credential_id, :integer
  end
end
