class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :consumer
      t.string :consumer_secret
      t.string :access
      t.string :access_secret
      t.integer :user_id

      t.timestamps
    end
    add_index :credentials, [:user_id, :created_at]
  end
end
