module SessionsHelper
	
	# Method for setting a cookie based on the remember_token
	# that is save in the database for that user.
	def sign_in(user)

		# Create a cookie called remember_token that is permanent or
		# for ruby expires in 20 years. It is assigned the value of
		# the remember_token set for the user when they were last updated.
		cookies.permanent[:remember_token] = user.remember_token

		# Call method the method current_user with self to allow it to
		# be visible to both the controller and views. The object user 
		# passes into it.
		self.current_user = user
	end

	# Test to see if current_user is set
	def signed_in?
		# Returns true if current_user is not(!) nil
		!current_user.nil?
	end

	# Method for assigning user object to an instance variable
	# @current_user. The = symbol means current_user = .. will
	# be converted to current_user=(...)
	def current_user=(user)

		# Instance vairiable current_user is assigned the 
		# value of user object.
		@current_user = user
	end

	def current_user
		# If current user is assigned then code is skipped, but if
		# it is unassigned that it goes to the database and finds
		# the user with a matching remember_token and returns a user object
		# to assign to @current_user.
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def current_user?(user)
		user == current_user
	end

	# Helper method for signing out a user
	def sign_out
		
		# Set the current_user for session to nil
		self.current_user = nil

		# Destroy cookie with hash remember_token
		# essentially letting the browser forget the user
		cookies.delete(:remember_token)
	end

	# Method to redirect user to another page
	def redirect_back_or(default)

		# redirects user to page stored in session symbol or the
		# dafault location if return_ to is not set.
		redirect_to(session[:return_to] || default)

		# Deletes the session symbol return_to
		session.delete(:return_to)
	end

	# Method to capture the url of the requested page
	def store_location

		# Stores the requested page in a session symbol return_to
		session[:return_to] = request.url
	end