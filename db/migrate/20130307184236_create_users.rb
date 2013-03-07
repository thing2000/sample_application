# Create table user with attributes name and email
# both of the type string.
class CreateUsers < ActiveRecord::Migration
  # Making change to database
  def change
    # Create table user
    # The t variable is a representation of table
    # Users, the pural convention is used to represent that
    # the table will hold many users.
    create_table :users do |t|
      # Create attribute name of type string for t variable
      t.string :name

      # Create attribute email of type string for t variable
      t.string :email

      # Two special attributes, created_at and updated_at,
      # are automatically created and givin the type datetime
      # with the currnt time.
      t.timestamps
    end
  end
end
