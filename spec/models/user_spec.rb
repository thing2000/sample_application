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
	before do
		@user = User.new(name: "Example User", email: "user@example.com")
	end

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

	# Test to see if validation catched invalid email formats
	describe "- When email format is invalid" do
		
		# Test email validation using invalid email entries
		it "- Should be invalid" do
			
			# Array of invalid emails to test validation against
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
			
            # Loop through each email in the array and passes
            # into block to be tested.
			addresses.each do |invalid_address|
				
				# Give object attribute email the value if
				# block variable.
				@user.email = invalid_address
				
				# Test that the email is now not valid
				@user.should_not be_valid
			end
		end
	end

	# Test to see if the validation recognizes valid emails
	describe "- When email format is valid" do
		
		# Test emails entries that should be valid
		it "- Should be valid" do
			
			# Array of valid email entries
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			
			# Pass each email entry into block using block varialbe
			# valid_address
			addresses.each do |valid_address|
				
				# Assign the object attribute email with the block variable
				@user.email = valid_address

				# Test to see if email is valid
				@user.should be_valid
			end
		end
	end

	# Test to ensure email uniqueness stops matching emails
	describe "- When email address is already taken" do
		# Create duplicate email and save to the database before
		# testing for uniqueness. This will ensure that same email
		# already exist.
		before do
			# Duplicate user object and assign it to new variable
			user_with_same_email = @user.dup

			# Set email to uppercase
			user_with_same_email.email = @user.email.upcase
			
			# Save duplicate user to database
			user_with_same_email.save
		end

		# With duplicate email saved to database, check
		# that user email is invalid.
		it { should_not be_valid }
	end
end