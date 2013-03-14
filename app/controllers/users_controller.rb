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
  	# with database query using the id hash from
    # the params hash sent by the page through the
    # GET method.
  	@user = User.find(params[:id])
  end

  # Called upon when a new user it to be saved/created
  # in the database. This is part of the REST architechure.
  def create

    # Creates a new @user object giving it that attributes
    # sent from the page through the POST method. These are
    # stored in a hash :user. The params is a hash of hashes.
    @user = User.new(params[:user])
    
    # Attempts to save the @save object to the database.
    if @user.save

      # After a successful save of the user sign them in
      sign_in @user

      # Create a flash hash sucess with welcome message.
      flash[:success] = "Welcome to the Sample App!"
      # Redirects to show page of the user controller
      redirect_to @user
    
    # If if failed this code is executed.
    else
      # 
      render 'new'
    end
  end
end
