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

		# Test that the signup page has a h1 tage containing
		# content Sign Up.
		it { should have_selector 'h1', text: 'Sign up' }

		# Test that the signup page has a title tag that contains
		# the content Sign Up.
		it { should have_selector 'title', text: full_title('Sign up') }
	end
end
