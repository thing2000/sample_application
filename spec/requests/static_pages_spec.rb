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

	# These test will be run for each static_pages
	# This can be used by calling its name "all static pages"
	shared_examples_for "all static pages" do
		# Test that the page has a h1 tag with content that matches
		# the value in heading variable
		it { should have_selector 'h1', text: head }

		# Test that the page has a title tag that with content that
		# matches the value in page_title variable
		it { should have_selector 'title', text: full_title(page_title) }
	end

	# Describes that home page is being tested.
	# Will be displayed in the event of a failed test.
	describe "- Home page" do
		
		# The before will be executed at the start of ever
		# test. Each time it is called a simulated visit to
		# root_path will occur.
		before { visit root_path }
		
		# Set the value of heading variable to Sample App
		let(:head) { 'Sample App' }

		# Set the value of page_title to ""
		let(:page_title) { '' }

		
		# Now that the value of heading and page_title have been
		# set run the test "ass static pages" against the symbols.
		it_should_behave_like "all static pages"

		# Test looks at home page and ensures that it does not
		# contail a custom title.
		it { should_not have_selector 'title', text: '| Home' }

		describe "- For signed-in users" do

			# Create a user to be used in the test
			let(:user) { FactoryGirl.create(:user) }
			
			# Do before each test
			before do

				# Create two micropost for the test
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
				FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
				
				# Signin the user
				sign_in user

				# Visit the homepage
				visit root_path
			end

			# Test that feeds for user are on homepage
			it "- Should render the user's feed" do
				
				# Cycle through feeds array for user pass them into
				# block variable item.
				user.feed.each do |item|

					# Test that page should have li with content of feed micropost
					page.should have_selector("li##{item.id}", text: item.content)
				end
			end

			# Test that count for following and followers work
			describe "follower/following counts" do
		        
				# Create a user for test
		        let(:other_user) { FactoryGirl.create(:user) }
		        
		        before do
		          
		          # Other_user now follow user
		          other_user.follow!(user)
		          
		          # Visit homepage
		          visit root_path
		        end

		        # User should have link showing 0 following and a link to the
				# the users following page
		        it { should have_link("0 following", href: following_user_path(user)) }
		        
		        # User should have link showing 1 followed and a link to the
				# the users followed page
		        it { should have_link("1 followers", href: followers_user_path(user)) }
      		end
		end
	end

	# Describe that help page is being tested.
	# Will be displayed in the event of a failed test.
	describe "- Help page" do

		# Before each test a sumilated visit to help_path
		# will occur.
		before { visit help_path }

		# Set the value of head to Help.
		let(:head) { 'Help' }

		# Set the value of page_title to Help.
		let(:page_title) { 'Help' }

		# Run "all static pages" tests passing the symbols
		# head and page_title.
		it_should_behave_like "all static pages"
	end

	# Describe that the about page is being tested.
	# Will be displayed if test fails.
	describe "- About page" do

		# Before each test a simulated visit to about_path will occur
		before { visit about_path }

		# Set the value of head to About us
		let(:head) { 'About Us' }

		# Set the value of page_title to About us
		let(:page_title) { 'About Us'}

		# Run the test in all static pages passing
		# the symbols head and page_title
		it_should_behave_like "all static pages"
	end

	# Describe that the contact page is being tested.
	# Will be displayed if test fails.
	describe "- Contact page" do

		# Before each test a sumulated visit to contact_path occurs
		before { visit contact_path }

		# Set the value of head to Contact
		let(:head) { 'Contact' }

		# Set the value of page_title to Contact
		let(:page_title) { 'Contact' }

		# Run the test in all static pages passing
		# the symbols head and page_title
		it_should_behave_like "all static pages"
	end

	it "should have the right links on the layout" do
		visit root_path
		click_link "About"
		page.should have_selector 'title', text: full_title('About Us')
		click_link "Help"
		page.should have_selector 'title', text: full_title('Help')
		click_link "Contact"
		page.should have_selector 'title', text: full_title('Contact')
		click_link "Home"
		click_link "Sign up now!"
		page.should have_selector 'title', text: full_title('Sign up')
		click_link "sample app"
		page.should have_selector 'title', text: full_title('')
	end
end