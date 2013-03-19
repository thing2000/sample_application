# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Relationship do

  #Create a user object that will be the follower
  let(:follower) { FactoryGirl.create(:user) }

  # Create a user object that will be the followed
  let(:followed) { FactoryGirl.create(:user) }

  # Create simulated relationship built on the follower
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  # Make relationship the subject of the test
  subject { relationship }

  # Test that relationship is a valid object
  it { should be_valid }

  # Test that for attribute visibility
  describe "- Accessible attributes" do
    
  	# Test that follower_id is not visible
    it "- Should not allow access to follower_id" do
      expect do
        
        # Try to insert into follower_id
        Relationship.new(follower_id: follower.id)
      
      # Should raise an error
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  # Test that relationships has follower and followed
  describe "- Follower methods" do

    # Test that relationship has follower    
    it { should respond_to(:follower) }

    # Test that relationship has followed
    it { should respond_to(:followed) }

    # Insure that follower was assigned to object correctly
    its(:follower) { should == follower }


    # Insure that followed was assigned to object correctly
    its(:followed) { should == followed }
  end

  describe "- When followed id is not present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "- When follower id is not present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end
end
