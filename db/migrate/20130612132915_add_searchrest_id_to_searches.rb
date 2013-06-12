class AddSearchrestIdToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :searchrest_id, :integer
  end
end
