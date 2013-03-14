class AddRememberTokenToUsers < ActiveRecord::Migration
  
  # Make changes to batabase
  def change
  	
  	# Add remember_token to users table and make it datatype string
  	add_column :users, :remember_token, :string

  	# Add index of remember_token for quicker query
  	add_index :users, :remember_token
  end
end
