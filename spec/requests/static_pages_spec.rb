# Gives this file access to spec_helper.rb.
require 'spec_helper'

# Describe that static_pages are being tested.
# Displays on the screen when failure occurs.
describe "Static pages" do
	# Describes that home page is being tested.
	# Will be displayed in the event of a failed test.
	describe "- Home page" do
		
		# Describe what is being tested about home page.
		it "- Should have the content 'Sample App'" do
			
			# Test simulates a user visiting the site.
			visit '/static_pages/home'

			# Test looks within the page for
			# the content Sample App.
			page.should have_content('Sample App')	

		end
	end

	# Describe that help page is being tested.
	# Will be displayed in the event of a failed test.
	describe "- Help page" do

		# Describes what is being tested about the 
		# help page.
		it "- Should have the content 'Help'" do
			
			# Test simulates a user visiting the site.
			visit '/static_pages/help'

			# Text looks at the content of the help.
			# page to see if it has content Help.
			page.should have_content('Help')
		end
	end

	# Describe that the about page is being tested.
	# Will be displayed if test fails.
	describe "- About page" do

		# Describes what is being tested about the
		# about page.
		it "- Should have the content 'About Us'" do

			# Test simulates a user visiting the site.
			visit '/static_pages/about'

			# Text looks at the content of the about
			# page to see if it has content About Us
			page.should have_content('About Us')
		end
	end
end