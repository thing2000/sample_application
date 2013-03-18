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
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

# Gives file access to spec_helper 
require 'spec_helper'

# Describes that test is for the User model
describe User do

	# Before each test a local object of User model is created 
	# filling the attributes name and email with dummy information.
	before do
		@user = User.new(name: "Example User", email: "user@example.com", 
			password: "foobar", password_confirmation: "foobar")
	end

	# Makes @user the subject of each test
	subject { @user }

	# Test to see if there is a attribute name
	# locate in @user object
	it { should respond_to(:name) }

	# Test to see if there is a attribute email
	# locate in @user object
	it { should respond_to(:email) }

	# Test to see if there is a attribute password_digest
	# locate in @user object
	it { should respond_to(:password_digest) }

	# Test to see if there is a attribute password
	# locate in @user object
	it { should respond_to(:password) }

	# Test to see if there is a attribute password_confirmation
	# locate in @user object
	it { should respond_to(:password_confirmation) }

	# Test to see if there is a nattribute remember_token
	# located in @user object
	it { should respond_to(:remember_token) }

	# Test to see is there is a attribute authenticate
	# located in @user object.
	it { should respond_to(:authenticate) }

	# Test to insure that @user object has microposts attribute
	it { should respond_to(:microposts) }

	# Test to see if @user object contains feed attribute
	it { should respond_to(:feed) }

	# Test that @user object has the admin attribute
	it { should respond_to(:admin) }

	# Test that the current state of the @user object
	# is valid
	it { should be_valid }

	# Test tht the default state of admin is false
	it { should_not be_admin }

	describe "- With admin attribute set to 'true'" do
		before do
			@user.save!
			@user.toggle!(:admin)
		end

		it { should be_admin }
	end

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

	# Test that email is downcased before saved
	describe "- Email address with mixed case" do
		
		# Set mixed_case_email to a mixed case email
		let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

		# Test that email is downcased
		it "- Should be saved as all lower-case" do
			# Set @user object's email to mixed_case_email
			@user.email = mixed_case_email

			# Save @user object to database
			@user.save

			# Save that email saved in database matches mix_case_email
			# downcased.
			@user.reload.email.should == mixed_case_email.downcase
		end
	end

	# Test to ensure empty password will be invalid
	describe "- When password is not present" do

		# Set password and password_confirmation of the @user
		# object to empty.
		before { @user.password = @user.password_confirmation = " " }

		# Test blank passwords to ensure they are invalid.
		it { should_not be_valid }
	end

	# Test for password and password_confirmation mismatch
	# will lead to them being invalid.
	describe "- When password doesn't match confirmation" do
		
		# Set password_confirmation to mismatch so it will
		# not be the same a password.
		before { @user.password_confirmation = "mismatch" }
		
		# Test to ensure that the unmatching password and
		# password_confirmation are invalid.
		it { should_not be_valid }
	end

	# Test password_confirmation is invalid when nil
	describe "- When password confirmation is nil" do
		
		# Set password_confirmation to nil
		before { @user.password_confirmation = nil }
		
		# Test that password_confirmation having the
		# value on nil is invalid.
		it { should_not be_valid }
	end

	# Test to ensure that a password that is to short will be invalid
	describe "- With a password that's too short" do
		
		# Set the password and password_confirmation to aaaaa
		before { @user.password = @user.password_confirmation = "a" * 5 }
		
		# Test that the password is under six characters and should 
		# be invalid.
		it { should be_invalid }
	end

	# Test to see if password validation is working
	describe "- Return value of authenticate method" do
		
		# Save the @user object to the database
		before { @user.save }
		
		# Set symbol found_user to the object returned
		# from find_by_email request sending the @user email
		# as search param.
		let(:found_user) { User.find_by_email(@user.email) }

		# Test to see is system accepts valid password
		describe "- With valid password" do
			
			# Test to ensure that both password match
			it { should == found_user.authenticate(@user.password) }
		end

		# Test that system catches password mismatch
		describe "- With invalid password" do
			
			# Set variable to invalid to ensure a mismatch
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			# Test that the two mismatch passwords are invalid
			it { should_not == user_for_invalid_password }
			
			# Test that user_for_invalid is false
			specify { user_for_invalid_password.should be_false }
		end
	end

	# Test the remember token 
	describe "- Remember token" do
		
		# Before test save the user to the database and it the
		# process a remember_token should be created.
		before { @user.save }

		# Test to see it token is not blank
		its(:remember_token) { should_not be_blank }
	end

	describe "- Micropost associations" do
		
		# Save @user to the database
		before { @user.save }
		
		# Create a micropost for one day ago
		let!(:older_micropost) do
			FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
		end

		# Create a micropost for on hour ago
		let!(:newer_micropost) do
			FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
		end

		# Test that the order is descending
		it "- Should have the right microposts in the rignt opder" do
			@user.microposts.should == [newer_micropost, older_micropost]
		end

		# Test that when user is destroyed so it theri micropost
		it "- Should destroy associated microposts" do
			
			# Duplicate users micropost
			microposts = @user.microposts.dup
			
			# Destroy the user
			@user.destroy

			# Ensure micropost duplication is will there
			microposts.should_not be_empty

			# Cycle through array of microposts
			microposts.each do |micropost|

				# Insure that the user_id is nil after user deleted
				Micropost.find_by_id(micropost.id).should be_nil
			end
		end

		# Test what micropost are being displayed
		describe "- Status" do

			# Get micropost for user and assign to symbol unfollowed_post
			let(:unfollowed_post) do
				FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
			end

			# Test that micropost includes post for current user 
			# but not post for unfollowed users.
			its(:feed) { should include(newer_micropost) }
			its(:feed) { should include(older_micropost) }
			its(:feed) { should_not include(unfollowed_post) }
		end
	end
end
