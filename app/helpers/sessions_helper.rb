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
end