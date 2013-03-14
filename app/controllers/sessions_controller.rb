class SessionsController < ApplicationController

	def new
	end

	def create
	    
	    # Get user from database using the email from the sessions hash.
	    # Downcase it to ensure no case issues arise.
	    user = User.find_by_email(params[:session][:email].downcase)

	    # Test to see it user exist and that password matches using
	    # the authenticate method by pulling encrypted hash from database
	    # and testing it to the encrtpeted hash created from the password
	    # stored in the session hash.
	    if user && user.authenticate(params[:session][:password])
	    	# Call method sign_in passing user in a parameter to sing in the user
	    	sign_in user

	    	# Redirect to the profile page for the user
	    	redirect_to user
	    # If authentication failes code is executed
	    else
	      # Flash now generated a error message that will not persist
	      # if link if click instead of submit.
	      flash.now[:error] = 'Invalid email/password combination'

	      # Reload the page
	      render 'new'
	    end
	end

	def destroy
	end
end
