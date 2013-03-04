# Gives this file access to spec_helper.rb
require 'spec_helper'

# Describe that static_pages are being tested
# Displays on the screen when failure occurs
describe "Static pages" do
	# Describes that home page is being tested
	# Will be displayed in the event of a failed test
	describe "Home page" do
		
		# Describe what is being tested about home page
		it "should have the content 'Sample App'" do
			
			# Test simulates a user visiting the site
			visit '/static_pages/home'

			# Test looks within the page for
			# the content Sample App.
			page.should have_content('Sample App')
		end
	end
end