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
  
  # Before each of the following test
  before do
    # This code is wrong!
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
  end

  # Tells test that @micropost will be the subject of the test
  subject { @micropost }

  # Test that content is a attribute in the micropost table
  it { should respond_to(:content) }

  # Test that user_id is a attribut in the micropost table
  it { should respond_to(:user_id) }

  # Test for missing user_id
  describe "- When user_id is not present" do
    
  	# Sets the user_id to nil in @micropost object
    before { @micropost.user_id = nil }

    # Insure that @micropost is no a valid object any longer
    it { should_not be_valid }
  end
end

