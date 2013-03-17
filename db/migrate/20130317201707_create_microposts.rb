class CreateMicroposts < ActiveRecord::Migration
  # Change the database
  def change

  	# Create a table micropost assign it to block variable t
    create_table :microposts do |t|

      # Create attribute content with type string
      t.string :content

      # Create a attriburte user_id with type integer
      t.integer :user_id

      # used to assign value for created_at and updated_at
      t.timestamps
    end

    # Add index with user_id and created_at as keys to array
    # This will allow quick search of most recent entries by user
    add_index :microposts, [:user_id, :created_at]
  end
end
