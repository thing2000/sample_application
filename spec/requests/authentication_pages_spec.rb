require 'spec_helper'

# Test for authentication pages
describe "Authentication" do
	
	# Lets test know that the subject of the test will always
	# be the page.
	subject { page }

	# Test for Signin page
	describe "- Signin" do
		
		# Visit the signing page before each test
		before { visit signin_path }

		# Test invalid entry for page
		describe "- With invalid information" do
			
			# Before each test click the Sign in button
			before { click_button "Sign in" }

			# Signing page should have title Sign in in its text
			it { should have_selector('title', text: 'Sign in') }
			
			# Signin page should have a error message containing text Invalid
			# located in a div tag.
			it { should have_selector('div.alert.alert-error', text: "Invalid") }
		end

		# Test page with valid entry
		describe "- With valid information" do

			# Create a user object for use in test
			let(:user) { FactoryGirl.create(:user) }

			# Run before each test
			before do
				# Fill in the email with user's email to ensure
				# it will be a valid email. Uppercase it for case
				# insensitive databases.
				fill_in "Email", with: user.email.upcase
				
				# Fill in password with user supplied password
				fill_in "Password", with: user.password

				# Click Sign in button to submit valid information
				click_button "Sign in"
			end

			# Page should have user name in the title
			it { should have_selector('title', text: user.name) }
			
			# There should be a link to profile page with link to
			# user's profile page
			it { should have_link('Profile', href: user_path(user)) }
			
			# There should be a link to sign out the user
			it { should have_link('Sign out', href: signout_path) }
			
			# There should not be a signin link on the page after successful
			# signin has occured.
			it { should_not have_link('Sign in', href: signin_path) }
		end
	end
end
