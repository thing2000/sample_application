# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  
  # Tells rails witch attributes in the User model
  # that is accessible. These attributes can be modified
  # by the outside world.
  attr_accessible :email, :name

  # Ensures that the user object does not have
  # an empty name attribute before saving to the
  # database.
  validates :name, presence: true
end
