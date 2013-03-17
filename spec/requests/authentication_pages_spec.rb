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

			# Page should have a link to index page
			it { should have_link('User', href: users_path) }
			
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

			# Test for when user visited a protected page when not-signed-in 
			describe "- When attempting to visit a protected page" do
				
				# Do before each test
				before do
					
					# Visit to the edit page and should be redirected 
					# to sign in page.
					visit edit_user_path(user)
					
					# Fill in the email form on the signin page
					fill_in "Email", with: user.email
					
					# Fill in the password form on the signin page
					fill_in "Password", with: user.password
					
					# Submit form for authentication
					click_button "Sign in"
				end

				# Describes what should happen after successfully signin in
				describe "- After signing in" do

					# Test that the protected page the user was trying to access
					# is being rendered after sign in.
					it "- Should render the desired protected page" do
						
						# Test that the title contains Edit user. This was the 
						# protected page the test was trying to load.
						page.should have_selector('title', text: 'Edit user')
					end
				end
			end

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

			# Test for the site index wile not signed-in
			describe "- Visiting the user index" do

				# Visit the user_path
				before { visit users_path }

				# The title of the page should have signin in it. This is
				# because the user was recirected to the signin page to
				# sign-in before accessing the index page.
				it { should have_selector('title', text: 'Sign in') }
			end
		end

		describe "- As non-admin user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:non_admin) { FactoryGirl.create(:user) }

			before { sign_in non_admin }

			describe "- Submitting a DELETE request to the User#destroy action" do
				before { delete user_path(user) }
				sepcify { response.should redirect_to(root_path) }
			end
		end
	end

	# Test for user unable to edit another user profile
	describe "- As wrong user" do

		# Create a user  object and assign it to user symbol
		let(:user) { FactoryGirl.create(:user) }

		# Create a user object with custom email and assign to symbo; wrong_user
		let(:wrong_user) { FactoryGirl.create(:user, email: "wron@example.com") }

		# Before each test sign in the user
		before { sign_in user }

		# Test that user cannot visit another persons edit page.
		describe "- Visiting User#edit page" do

			# Visit the edit page using the wrong user object
			before { visit edit_user_path(wrong_user) }

			# Page should not have Edit user in the title page as it
			# should not let the user open the edit page.
			it { should_not have_selector('title', text: full_title('Edit user')) }
		end

		# Test that user cannot update information for another user
		describe "- Submitting a PUT request to the User#update action" do
			
			# Attempt to update user with wrong user object
			before { put user_path(wrong_user) }

			# Attempt to update should cause a redirect to home page.
			specify { response.should redirect_to(root_path) }
		end
	end
end
