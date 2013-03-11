class UsersController < ApplicationController
  def new
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
