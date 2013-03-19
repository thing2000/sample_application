class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
  end

  add_index :relationships, :follower_id
  add_index :relationships, :followed_id

  # Make sure that user cannot follow same user twice
  add_index :relationships, [:follower_id, :followed_id], unique: true
end
