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
end
