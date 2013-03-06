# Gives this file access to spec_helper.rb.
require 'spec_helper'

# Describe that static_pages are being tested.
# Displays on the screen when failure occurs.
describe "Static pages" do

	# Create variable base_title and assigne default page title
	# This will be used throughout the test 
	let(:base_title) { "Ruby on Rails Tutorial Sample App" }
	
	# Eliminates the need for telling each test what the subject
	# of each test should be. This means we can elimitace the page
	# before each should.
	subject { page }

	# Describes that home page is being tested.
	# Will be displayed in the event of a failed test.
	describe "- Home page" do
		
		# The before will be executed at the start of ever
		# test. Each time it is called a simulated visit to
		# root_path will occur.
		before { visit root_path }

		# Test looks at home page and determines if it has
		# a h1 tag with the contents of Sample App.
		it { should have_selector 'h1', text: 'Sample App' }

		# Test looks at home page and dertermines if it has
		# a title tag and if it contains predefined text.
		it { should have_selector 'title', text: full_title('') }

		# Test looks at home page and ensures that it does not
		# contail a custom title.
		it { should_not have_selector 'title', text: '| Home' }
	end

	# Describe that help page is being tested.
	# Will be displayed in the event of a failed test.
	describe "- Help page" do

		# Before each test a sumilated visit to help_path
		# will occur.
		before { visit help_path }

		# Test will see if help page has tag h1 with
		# the content of Help.
		it { should have_selector 'h1', text: 'Help' }

		# Test will see if help page has a tag title with
		# a custom title comtaining Help.
		it { should have_selector 'title', text: full_title('Help') }
	end

	# Describe that the about page is being tested.
	# Will be displayed if test fails.
	describe "- About page" do

		# Before each test a simulated visit to about_path will occur
		before { visit about_path }

		# Test the about page for a h1 tab containing About Us
		it { should have_selector 'h1', text: 'About Us' }

		# Test the about page for a title tag containing a custom
		# content containing | About Us
		it { should have_selector 'title', text: full_title('About Us') }
	end

	# Describe that the contact page is being tested.
	# Will be displayed if test fails.
	describe "- Contact page" do

		# Before each test a sumulated visit to contact_path occurs
		before { visit contact_path }

		# Test to see if contact page has a h1 tag that contains
		# the content Contact
		it { should have_selector 'h1', text: 'Contact' }

		# Test to see if contact page has a title tag that contails
		# the content Contact
		it { should have_selector 'title', text: full_title('Contact') }
	end
end