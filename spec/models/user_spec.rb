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

# Gives file access to spec_helper 
require 'spec_helper'

# Describes that test is for the User model
describe User do

	# Before each test a local object of User model is created 
	# filling the attributes name and email with dummy information.
	before { @user = User.new(name: "Example User",
		email: "user@example.com") }

	# Makes @user the subject of each test
	subject { @user }

	# Test to see if there is a attribute in the @user
	# object has attributes that responds to the name
	# symbol.
	it { should respond_to(:name) }

	# Test to see if there is a attribute in the @user
	# object has attributes that responds to the email
	# symbol.
	it { should respond_to(:email) }
end
