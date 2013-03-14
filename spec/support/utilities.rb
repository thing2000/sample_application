# Give access to the application_helper_spec.rd file
# and the ApplicationHelper.
include ApplicationHelper

# Simulate user sign in using user object passed in
def sign_in(user)
	
	# Visit the signin page
	visit signin_path

	# Fill in the email form with email from user object
	fill_in "Email", with: user.email

	# Fill in the password from password in user object
	fill_in "Password", with: user.password
	
	# Click the submit button to sign in
	click_button "Sign in"

	# Set browser cookie remember_token to the same as token in user object
	cookies[:remember_token] = user.remember_token
end