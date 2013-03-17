# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

# Test describe the micropost model
describe Micropost do

  # Create a new user object and assign to symbol user
  let(:user) { FactoryGirl.create(:user) }
  
  # Before each of the following test create a micropost object
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }

  # Tells rails that micropost is the subject of the test
  subject { @micropost }

  # @micropost should have cotent attribute
  it { should respond_to(:content) }

  # @micropost should have user_id as attribute 
  it { should respond_to(:user_id) }

  # The user tied to the micropost should be the same and the user created
  it { should respond_to(:user) }
  its(:user) { should == user }
 
  # Test for missing user_id
  describe "- When user_id is not present" do
    
  	# Sets the user_id to nil in @micropost object
    before { @micropost.user_id = nil }

    # Insure that @micropost is no a valid object any longer
    it { should_not be_valid }
  end

  # Test that a blank micropost will not be valid
  describe "- With blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  # Test that content cannot be over 140 characters
  describe "- With content that is too long" do
    before { @micropost.cotent = "a" * 141 }
    it { should_not be_valid }
  end

  # Test for acessible attributes
  describe "- Accessible attributes" do

    # Test for access to user_id should be denied
    it "- Should not allow access to user_id" do
      
      # What to expect
      expect do

        # Try to manually set user_id
        Micropost.new(user_id: user.id)

      # Should throw an error
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end

