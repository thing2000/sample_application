# Give the file access to spec_helper.rb
require 'spec_helper'

# Describes that test are for user pages
describe "UserPages" do
	
	# Lets test know that the page is the subject of the test
	subject { page }

	# Test for the index page
	describe "- Index" do
		
		# Create a user object and asign it the variable user
		let(:user) { FactoryGirl.create(:user) }

		# Before each test go through block of code
		before(:each) do
			
			# Sign in the user using user object
			sign_in user

			# Visit the index page
			visit users_path
		end

		# Page should have a title with All users in it
		it { should have_selector('title', text: 'All users') }

		# Page should have a h1 tag that will have the content
		# of All users in it.
		it { should have_selector('h1', text: 'All users') }

		
		# Test for pagination existance on page
		describe "- Pagination" do
			
			# Generate 30 users for the test
			before(:all) { 30.times { FactoryGirl.create(:user) } }

			# Remove the users generated for the tast
			after(:all) { User.delete_all }

			# Page should hav div pagination
			it { should have_selector('div.pagination') }

			# Test that pagination contains list item with user name
			it "- Should list each user" do

				# Cycle through each user
				User.paginate(page: 1).each do |user|

					# Ensure that each user will have li with the user name
					# in it.
					page.should have_selector('li', text: user.name)
				end
			end
		end

		# Test to insure that delete user works 
		describe "- Delete links" do
			
			# Test that normal user cannot see delete link
			it { should_not have_link('delete') }

			# Test to see if delete for an user that is a admin
			describe "- As an admin user" do
				
				# Create a user that is a admin
				let(:admin) { FactoryGirl.create(:admin) }
				
				# Do before each test
				before do
					
					# Sign in the user
					sign_in admin

					# Visit the index page
					visit users_path
				end

				# User should see the delete link
				it { should have_link('delete', href: user_path(User.first)) }
				
				# after delete link is pressed number of users in databasae
				# should be on less.
				it "- Should be able to delete another user" do
					expect { click_link('delete') }. to change(User, :count).by(-1)
				end
				
				# Profile for admin on index page should not have a delete link
				it { should_not have_link('delete', href: user_path(admin)) }
			end
		end
	end

	# Describe that test is for the signup page
	describe "- Signup page" do

		# Before each test a simulated a visit to signup page
		before { visit signup_path }

		# Symbol that has the value of the submit button
		# on the signup page.
		let(:submit) { "Create my account" }

		# Test that the signup page has a h1 tage containing
		# content Sign Up.
		it { should have_selector 'h1', text: 'Sign up' }

		# Test that the signup page has a title tag that contains
		# the content Sign Up.
		it { should have_selector 'title', text: full_title('Sign up') }

		# Test submitting a blank form will be invalid
		describe "- With invalid information" do
		
			# Test that a user should not be created with blank form
			it "- Should not create a user" do
				
				# Counts number of users in database. Then it submits
				# a blank form to the model for processing. Finally it
				# counts the number of users in the database to ensure
				# that it has not increased.
				expect { click_button submit }.not_to change(User, :count)
			end

			# Test that error messages are being displayed on reload
			# of the signup page.
			describe "- After submission" do
				
				# Simulates a clicking of the submit button before
				# each test is run.
				before { click_button submit }

				# Test that the page has a title tag with the value
				# of Sign up. 
				it { should have_selector('title', text: 'Sign up') }
				
				# Test that the page has error within the content of the
				# page indicating an error message has been generated.
				it { should have_content('error') }
			end
		end

		# Test that valid forms will be saved to database
		describe "- With valid information" do
			
			# Fill in forms with valid information before each test
			before do
				fill_in "Name", with: "Example User"
				fill_in "Email", with: "user@example.com"
				fill_in "Password", with: "password"
				fill_in "Confirmation", with: "password"
			end

			# Count the number of users in the database. Then submit
			# the valid form information to the model to be processed.
			# Finally count the number of users in database to ensure
			# that it has increated by one.
			it "- Should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			# Insure profile page is loaded with new user name
			describe "- After saving the user" do
				
				# Simulate a submit button click before each test
				before { click_button submit }

				# Gets the user object from model for email address
				let(:user) { User.find_by_email('user@example.com') }

				# Test to see it page has new user name in title
				it { should have_selector('title', text: user.name) }
				
				# Test to see if alert has test Welcome in it.
				it { should have_selector('div.alert.alert-success',
					text: 'Welcome') }

				# Test that after the new user signs up they are also
				# signed in and have a sign out link apprear on the page
				it { should have_link('Sign out') }
			end
		end
	end

	# Test are for the profile page
	describe "- Profile page" do
		
		# Create a user factory and assign it to user variable
		let(:user) { FactoryGirl.create(:user) }

		# Create a micropost with content Foo to user created for test
		let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }

		# Create a micropost with content Bar to user created for test
		let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

		# Before each test visit user_path route passing in
		# user variable as parameter.
		before { visit user_path(user) }

		# Test that the page has a h1 tag with the users name
		# populated within it.
		it { should have_selector('h1', text: user.name) }

		# Test that the page has a title tag with the users name
		# populated within it.
		it { should have_selector('title', text: user.name) }

		# Test for micropost
		describe "- Microposts" do

			# Test that m1 has content
			it { should have_content(m1.content) }

			# Test that m2 has content
			it { should have_content(m2.content) }

			# Test that there is micropost count
			it { should have_content(user.microposts.count) }
		end

		describe "follow/unfollow buttons" do
      		let(:other_user) { FactoryGirl.create(:user) }
     		before { sign_in user }

      		describe "following a user" do
        		before { visit user_path(other_user) }

        		it "should increment the followed user count" do
          			expect do
            			click_button "Follow"
          			end.to change(user.followed_users, :count).by(1)
        		end

        		it "should increment the other user's followers count" do
          			expect do
            			click_button "Follow"
          			end.to change(other_user.followers, :count).by(1)
        		end

        		describe "toggling the button" do
          			before { click_button "Follow" }
          			it { should have_selector('input', value: 'Unfollow') }
        		end
      		end

      		describe "unfollowing a user" do
        		before do
          			user.follow!(other_user)
          			visit user_path(other_user)
        		end

        		it "should decrement the followed user count" do
          			expect do
            			click_button "Unfollow"
          			end.to change(user.followed_users, :count).by(-1)
        		end

        		it "should decrement the other user's followers count" do
          			expect do
            			click_button "Unfollow"
          			end.to change(other_user.followers, :count).by(-1)
       			 end

        		describe "toggling the button" do
          			before { click_button "Unfollow" }
          			it { should have_selector('input', value: 'Follow') }
        		end
      		end
    	end
	end

	# Test for the edit page for user information
	describe "- Edit" do
		
		# Create a new object of a user
		let(:user) { FactoryGirl.create(:user) }

		# Before each test visit the edit user page
		before do
			# Sign in the user
			sign_in user

			# Visit the edit page for the user
			visit edit_user_path(user)
		end

		# Tests describing what should be on edit page
		describe "page" do
			
			# Edit page should have a h1 tag with Update you profile as its content
			it { should have_selector('h1', text: "Update your profile") }

			# Edit page should have a title tag with Edit user within it content
			it { should have_selector('title', text: "Edit user") }

			# Edit page should have a link that takes links you to the gravatar page
			# to edit your gravatar
			it { should have_link('change', href: 'http://gravatar.com/emails') }
		end

		# Test for invalid submition of edit page
		describe "- With invalid information" do
			
			# Before each test click on the Save changes link
			# to submit the invalid information
			before { click_button "Save changes" }

			# Edit page should have error apppear on it
			# after an invalid submission.
			it { should have_content('error') }
		end

		# Test when user uses valid information
		describe "- With valid information" do
			
			# Create a symbol new_name with value New Name
			let(:new_name) { "New Name" }

			# Create a symbol new_email with a value new@example.com
			let(:new_email) { "new@example.com" }

			# Execute block before each test
			before do
				
				# Fillin the Name field of form with new name
				fill_in "Name", with: new_name

				# Fill in the Email field of the form with new email
				fill_in "Email", with: new_email

				# Fill in password with user's password
				fill_in "Password", with: user.password

				# Fill in confirm password field with user's password
				fill_in "Confirm Password", with: user.password

				# Click the submit button
				click_button "Save changes"
			end

			# Page should have new_name in the title
			it { should have_selector('title', text: new_name) }

			# Page should have alert with success message in it
			it { should have_selector('div.alert.alert-success') }

			# Page should have Sign out link on page
			it { should have_link('Sign out', href: signout_path) }

			# Reload the user to confirm name has been changes to new_name
			specify { user.reload.name.should == new_name }

			# Reload the user to confirm email has been changes to new-email
			specify { user.reload.email.should == new_email }
		end
	end

	describe "following/followers" do
    	let(:user) { FactoryGirl.create(:user) }
    	let(:other_user) { FactoryGirl.create(:user) }
    	before { user.follow!(other_user) }

    	describe "followed users" do
      		before do
        		sign_in user
        		visit following_user_path(user)
      		end

      		it { should have_selector('title', text: full_title('Following')) }
      		it { should have_selector('h3', text: 'Following') }
      		it { should have_link(other_user.name, href: user_path(other_user)) }
    	end

    	describe "followers" do
      	before do
        	sign_in other_user
       		visit followers_user_path(other_user)
      	end

      	it { should have_selector('title', text: full_title('Followers')) }
      	it { should have_selector('h3', text: 'Followers') }
      	it { should have_link(user.name, href: user_path(user)) }
    end
  end
end
