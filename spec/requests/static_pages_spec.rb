# Gives this file access to spec_helper.rb.
require 'spec_helper'

# Describe that static_pages are being tested.
# Displays on the screen when failure occurs.
describe "Static pages" do

	# Create variable base_title and assigne default page title
	# This will be used throughout the test 
	let(:base_title) { "Ruby on Rails Tutorial Sample App" }
	
	# Describes that home page is being tested.
	# Will be displayed in the event of a failed test.
	describe "- Home page" do
		
		# Describe what is being tested about home page.
		it "- Should have the content 'Sample App'" do
			
			# Test simulates a user visiting the site.
			visit root_path

			# Test looks at the h1 of the page for
			# the content Sample App.
			page.should have_selector('h1', :text => 
				'Sample App')	
		end

		# Test to see if home page has right title.
		it "- Should have the right title" do

			# Simulate user visiting the home page.
			visit root_path

			# Test to see if page has title and that
			# the title contains the proper format.
			page.should have_selector('title', :text => 
				"#{base_title}")
		end

		# Test to see if page does not have custom title | Home
		it "- Should not have a custom page title | Home" do
			
			#Simulate user visiting home page.
			visit root_path

			#Test to see if title does not have | Home in title.
			page.should_not have_selector('title', :text =>'| Home')
		end
	end

	# Describe that help page is being tested.
	# Will be displayed in the event of a failed test.
	describe "- Help page" do

		# Describes what is being tested about the 
		# help page.
		it "- Should have the content 'Help'" do
			
			# Test simulates a user visiting the site.
			visit help_path

			# Test looks at the h1 of the page for
			# the content Help.
			page.should have_selector('h1', :text => 
				'Help')
		end

		# Test to see if help page has right title.
		it "- Should have the right title" do

			# Simulate user visiting the help page.
			visit help_path

			# Test to see if page has title and that
			# the title contains the proper format.
			page.should have_selector('title', :text => 
				"#{base_title} | Help")
		end
	end

	# Describe that the about page is being tested.
	# Will be displayed if test fails.
	describe "- About page" do

		# Describes what is being tested about the
		# about page.
		it "- Should have the content 'About Us'" do

			# Test simulates a user visiting the site.
			visit about_path

			# Test looks at the h1 of the page for
			# the content About Us.
			page.should have_selector('h1', :text => 
				'About Us')
		end

		# Test to see if about page has right title.
		it "- Should have the right title" do

			# Simulate user visiting the about page.
			visit about_path

			# Test to see if page has title and that
			# the title contains the proper format.
			page.should have_selector('title', :text => 
				"#{base_title} | About Us")
		end
	end

	# Describe that the contact page is being tested.
	# Will be displayed if test fails.
	describe "- Contact page" do

		# Describes what is being tested about the
		# contact page.
		it "- Should have the content 'Contact'" do

			# Test simulates a user visiting the site.
			visit contact_path

			# Test looks at the h1 of the page for
			# the content Contact.
			page.should have_selector('h1', :text => 
				'Contact')
		end

		# Test to see if about page has right title.
		it "- Should have the right title" do

			# Simulate user visiting the contact page.
			visit contact_path

			# Test to see if page has title and that
			# the title contains the proper format.
			page.should have_selector('title', :text => 
				"#{base_title} | Contact")
		end
	end
end