class UsersController < ApplicationController
  
  # Call method signed_in_user passing in signed in user.
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy, :following, :followers]

  # Call method correct_user to ensure that user matches the user
  # they are trying to edit.
  before_filter :correct_user, only: [:edit, :update]

  # Filter to insure non-admin user cannot delete another user
  before_filter :admin_user, only: :destroy
  
  # When ever new.html.erb from users view is needed
  # the code within is execited and the page os proccessed.
  # offers up the page of the signin.
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

    # Load all the micropost for the user into a variable @microposts
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  # Called upon when a new user it to be saved/created
  # in the database. This is part of the REST architechure.
  # Compltetes to signin process after page submit.
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

  # Action that loads the edit user page
  def edit
  end

  # Action to update user information
  def update
    # If update of user information is successful
    if @user.update_attributes(params[:user])
      
      # Create a flash message sucess
      flash[:success] = "Profile updated"
      
      # Sign in the user
      sign_in @user

      # Redirect user to the profile page
      redirect_to @user
    
    # If update of user information fails
    else
      
      # Reload edit page
      render 'edit'
    end
  end

  # Action for index page
  def index

    # Put all users in a instance variable @user
    @users = User.paginate(page: params[:page])
  end

  def destroy
      User.find(params[:id]).destroy

      flash[:success] = "User destroyed."
      
      redirect_to users_path
    end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  # Only visivle in controller
  private
 
    # Check to see if current_user matches @user object. If it does not
    # it redirects user to home page.
    def correct_user

      # Get user object from database using the id and assignes it to @user
      @user = User.find(params[:id])

      # Redirects user to home page unless current user matches the user object.
      redirect_to(root_path) unless current_user?(@user)
    end

    # Before filter that ensured that is non-admin tries to delete it redirects
    # them to homepage.
    def admin_user

      # Test if user is not admin than it redirects to homepage.
      redirect_to(root_path) unless current_user.admin?
    end
end
