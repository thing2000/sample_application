class AddPasswordDigestToUsers < ActiveRecord::Migration
  # Change database
  def change
    # Add column password_digest to user and make it
    # type string.
    add_column :users, :password_digest, :string
  end
end
