# Give the file access to spec_helper.rb
require 'spec_helper'

# Describes that test are for user pages
describe "UserPages" do
	
	# Lets test know that the page is the subject of the test
	subject { page }

	# Describe that test is for the signup page
	describe "- Signup page" do

		# Before each test a simulated a visit to signup page
		before { visit signup_path }

		# Symbol that has the value of the submit button
		# on the signup page.
		let(:submit) { "Create my account" }

		# Test that the signup page has a h1 tage containing
		# content Sign Up.
		it { should have_selector 'h1', text: 'Sign up' }

		# Test that the signup page has a title tag that contains
		# the content Sign Up.
		it { should have_selector 'title', text: full_title('Sign up') }

		# Test submitting a blank form will be invalid
		describe "- With invalid information" do
		
			# Test that a user should not be created with blank form
			it "- Should not create a user" do
				
				# Counts number of users in database. Then it submits
				# a blank form to the model for processing. Finally it
				# counts the number of users in the database to ensure
				# that it has not increased.
				expect { click_button submit }.not_to change(User, :count)
			end

			# Test that error messages are being displayed on reload
			# of the signup page.
			describe "- After submission" do
				
				# Simulates a clicking of the submit button before
				# each test is run.
				before { click_button submit }

				# Test that the page has a title tag with the value
				# of Sign up. 
				it { should have_selector('title', text: 'Sign up') }
				
				# Test that the page has error within the content of the
				# page indicating an error message has been generated.
				it { should have_content('error') }
			end
		end

		# Test that valid forms will be saved to database
		describe "- With valid information" do
			
			# Fill in forms with valid information before each test
			before do
				fill_in "Name", with: "Example User"
				fill_in "Email", with: "user@example.com"
				fill_in "Password", with: "password"
				fill_in "Confirmation", with: "password"
			end

			# Count the number of users in the database. Then submit
			# the valid form information to the model to be processed.
			# Finally count the number of users in database to ensure
			# that it has increated by one.
			it "- Should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			# Insure profile page is loaded with new user name
			describe "- After saving the user" do
				
				# Simulate a submit button click before each test
				before { click_button submit }

				# Gets the user object from model for email address
				let(:user) { User.find_by_email('user@example.com') }

				# Test to see it page has new user name in title
				it { should have_selector('title', text: user.name) }
				
				# Test to see if alert has test Welcome in it.
				it { should have_selector('div.alert.alert-success',
					text: 'Welcome') }

				# Test that after the new user signs up they are also
				# signed in and have a sign out link apprear on the page
				it { should have_link('Sign out') }
			end
		end
	end

	# Test are for the profile page
	describe "- Profile page" do
		
		# Create a user factory and assign it to user variable
		let(:user) { FactoryGirl.create(:user) }

		# Before each test visit user_path route passing in
		# user variable as parameter.
		before { visit user_path(user) }

		# Test that the page has a h1 tag with the users name
		# populated within it.
		it { should have_selector('h1', text: user.name) }

		# Test that the page has a title tag with the users name
		# populated within it.
		it { should have_selector('title', text: user.name) }
	end

	# Test for the edit page for user information
	describe "- Edit" do
		
		# Create a new object of a user
		let(:user) { FactoryGirl.create(:user) }

		# Before each test visit the edit user page
		before { visit edit_user_path(user) }

		# Tests describing what should be on edit page
		describe "page" do
			
			# Edit page should have a h1 tag with Update you profile as its content
			it { should have_selector('h1', text: "Update your profile") }

			# Edit page should have a title tag with Edit user within it content
			it { should have_selector('title', text: "Edit user") }

			# Edit page should have a link that takes links you to the gravatar page
			# to edit your gravatar
			it { should have_link('change', href: 'http://gravatar.com/emails') }
		end

		# Test for invalid submition of edit page
		describe "- With invalid information" do
			
			# Before each test click on the Save changes link
			# to submit the invalid information
			before { click_button "Save changes" }

			# Edit page should have error apppear on it
			# after an invalid submission.
			it { should have_content('error') }
		end
	end
end
