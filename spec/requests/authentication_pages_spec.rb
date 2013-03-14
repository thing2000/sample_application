require 'spec_helper'

# Test for authentication pages
describe "Authentication" do
	
	# Lets test know that the subject of the test will always
	# be the page.
	subject { page }

	# Test for the signing page
	describe "signin page" do
		
		# Before each test visit the singin page
		before { visit signin_path }

		# The signin page should have a h1 tag containing the text
		# Sign in.
		it { should have_selector('h1', text: 'Sign in') }
		
		# The signin page should have a title tag containing the text
		# Sign in.
		it { should have_selector('title', text: 'Sign in') }
	end
end
