class CreateStreamings < ActiveRecord::Migration
  def change
    create_table :streamings do |t|
      t.string :query
      t.integer :user_id

      t.timestamps
    end
    add_index :streamings, [:user_id, :created_at]
  end
end
