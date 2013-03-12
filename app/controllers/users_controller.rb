class UsersController < ApplicationController
  
  # When ever new.html.erb from users view is needed
  # the code within is execited and the page os proccessed.
  def new

    # Creates a new object of the user model and
    # stores it in the instance variable @user.
    @user = User.new
  end

  # Show action for users.
  # Used to get and display user infromation
  # from database.
  def show
  	# Creates a @user variable that populates it
  	# with database query using the id attribute
  	# from the user table.
  	@user = User.find(params[:id])
  end
end
