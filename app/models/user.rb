# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  
  # Tells rails witch attributes in the User model
  # that is accessible. These attributes can be modified
  # by the outside world.
  attr_accessible :email, :name

  # Call back that ensures email will be lowercase
  before_save { |user| user.email = email.downcase }

  # Ensures that the user object does not have
  # an empty name attribute before saving to the
  # database. Also checks that the length does not exceed
  # the maximum of 50 characters.
  validates :name, presence: true, length: { maximum: 50 }

  # Regular expression to define the format
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  

  # Ensures that the user object does not have
  # an empty email attribute before saving to the
  # database. Also test email against the regular expression
  # for validation. The test checks for uniqueness and is case insensitive.
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  	uniqueness: {case_sensitive: false}
end
