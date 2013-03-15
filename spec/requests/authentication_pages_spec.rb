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

			# Ensure error message is not persistant
			describe "- After visiting another page" do
				
				# Visit home page 
				before { click_link "Home" }

				# Test to see is home page has error message on it by
				# looking to see it error div exist.
				it { should_not have_selector("div.alert.alert-error") }
			end
		end

		# Test page with valid entry
		describe "- With valid information" do

			# Create a user object for use in test
			let(:user) { FactoryGirl.create(:user) }

			# Before each test call sign_in method passing in user object
			before { sign_in user }

			# Page should have user name in the title
			it { should have_selector('title', text: user.name) }
			
			# There should be a link to profile page with link to
			# user's profile page
			it { should have_link('Profile', href: user_path(user)) }

			# There should be a link with the value Settings and link
			# to the edit user page.
			it { should have_link('Settings', href: edit_user_path(user)) }
			
			# There should be a link to sign out the user
			it { should have_link('Sign out', href: signout_path) }
			
			# There should not be a signin link on the page after successful
			# signin has occured.
			it { should_not have_link('Sign in', href: signin_path) }

			# Insure user can log out after signing in
			describe "- Follow by signout" do

				# Clink the sign out link before each test
				before { click_link "Sign out" }

				# Insure that the link for Sign out has
				# changed to Sign in.
				it {should have_link('Sign in') }
			end
		end
	end

	# Testing that non-sign-in users cannot access update or edit pages
	describe "- Authorization" do
		
		# Test for non-signed-users
		describe "- For non-signed-in users" do
			
			# Create a user object and assign it to user
			let(:user) { FactoryGirl.create(:user) }

			# Test for user controller
			describe "- In the Users controller" do
				
				# Insure that a visit to edit page takes non-signed-in
				# usres back to Sign-in page.
				describe "- Visiting the edit page" do

					# Before test visit edit page passing user object
					before { visit edit_user_path(user) }

					# Test that page has title Sign in
					it { should have_selector('title', text: 'Sign in') }
				end

				# Test that non-signed-in users cannot submit update action
				describe "- Submitting to the update action" do
					
					# Simulate a submit for update
					before { put user_path(user) }

					# See if it redirects to sign in page
					specify { response.should redirect_to(signin_path) }
				end
			end
		end
	end
end
