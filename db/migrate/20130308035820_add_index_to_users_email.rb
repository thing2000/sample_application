class AddIndexToUsersEmail < ActiveRecord::Migration
  # Change to database
  def change
  	# Changes table users by adding uniqueness
  	# constraint to email attribute
  	add_index :users, :email, unique: true
  end
end
