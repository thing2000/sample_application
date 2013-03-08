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

	# Test that the current state of the @user object
	# is valid
	it { should be_valid }

	# Test to ensure that when the name attribute 
	# is blank it will not be valid to save to the
	# database.
	describe "- When name is not present" do

		# Before test runs set the name attribute 
		# of the @user object to blank.
		before { @user.name = " " }

		# Test that the @user object is now not valid
		it { should_not be_valid }
	end

	# Test to ensure that when the email attribute 
	# is blank it will not be valid to save to the
	# database.
	describe "- When email is not present" do
		
		# Before test runs set the email attribute 
		# of the @user object to blank.
		before { @user.email = " " }

		# Test that the @user object is now not valid		
		it { should_not be_valid }
	end

	# Test to ensure that name length validation
	# is in place and working.
	describe "- When name is too long" do
		
		# Set the value of name to a string 51 characters
		# long.
		before { @user.name = "a" * 51 }

		# Test that the value in name is now not valid
		it { should_not be_valid }
	end
end