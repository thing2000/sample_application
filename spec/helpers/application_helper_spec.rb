# Gives file access to spec_helper.rb
require 'spec_helper'

# Name used to access the test from another file
describe ApplicationHelper do

  # When ever full_title is used in test these
  # test will be run
  describe "full_title" do
    # Test that if full_title have string passed
    # into it then that string should be in the
    # title.
    it "should include the page title" do
      full_title("foo").should =~ /foo/
    end

    # Test that it full title has string passed
    # into it then "Ruby on Rails Tutorial Sample App"
    # should be in the title.
    it "should include the base title" do
      full_title("foo").should =~ /^Ruby on Rails Tutorial Sample App/
    end

    # Test that if full_title is not passed a string in
    # then the | should not be in the title.
    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end
end