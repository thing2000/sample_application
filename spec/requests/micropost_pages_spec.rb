require 'spec_helper'

# Test for micropost pages
describe "Micropost pages" do

  # Tells rails page is subject of test
  subject { page }

  # Generate user object for test
  let(:user) { FactoryGirl.create(:user) }
  
  # Signin user
  before { sign_in user }

  # Test creation of micropost
  describe "micropost creation" do
    
    # Simulate visit to root path
    before { visit root_path }

    # Test for when invalid information is entered
    describe "with invalid information" do

      # Test that micropost was not created
      it "should not create a micropost" do
        
        # Simulate click submit and count micropost to see if count
        # has not changed.
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      # Test for error message
      describe "error messages" do
        
        # Simulate a button click
        before { click_button "Post" }

        # Page should have an error message on it
        it { should have_content('error') } 
      end
    end

    # Test for valid entry of information
    describe "with valid information" do

      # Fill in form with valid information
      before { fill_in 'micropost_content', with: "Lorem ipsum" }

      # Test that micropost is created
      it "should create a micropost" do

        # Sumilate button click and count micropost to see that one was added
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  # Test for destruction of micropost
  describe "- Micropost destruction" do
    
    # Create a micropost for test
    before { FactoryGirl.create(:micropost, user: user) }

    # Test that right user can delete micropost
    describe "- As correct user" do
      
      # Before test visit homepage
      before { visit root_path }

      # Insure deletion of micropose
      it "- Should delete a micropost" do
        
        # Click delete and count micropost to see if there is one less
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end
end