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

			# Test looks at the h1 of the page for
			# the content Sample App.
			page.should have_selector('h1', :text => 
				'Sample App')	
		end

		# Test to see if home page has right title.
		it "- Should have the right title" do

			# Simulate user visiting the home page.
			visit '/static_pages/home'

			# Test to see if page has title and that
			# the title contains the proper format.
			page.should have_selector('title', :text => 
				"Ruby on Rails Tutorial Sample App | Home")
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

			# Test looks at the h1 of the page for
			# the content Help.
			page.should have_selector('h1', :text => 
				'Help')
		end

		# Test to see if help page has right title.
		it "- Should have the right title" do

			# Simulate user visiting the home page.
			visit '/static_pages/help'

			# Test to see if page has title and that
			# the title contains the proper format.
			page.should have_selector('title', :text => 
				"Ruby on Rails Tutorial Sample App | Help")
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

			# Test looks at the h1 of the page for
			# the content About Us.
			page.should have_selector('h1', :text => 
				'About Us')
		end

		# Test to see if about page has right title.
		it "- Should have the right title" do

			# Simulate user visiting the home page.
			visit '/static_pages/about'

			# Test to see if page has title and that
			# the title contains the proper format.
			page.should have_selector('title', :text => 
				"Ruby on Rails Tutorial Sample App | About Us")
		end
	end
end