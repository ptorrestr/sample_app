class AddCredentialIdToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :credential_id, :integer
  end
end
