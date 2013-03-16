# Source rails will look to for gemfiles 
# that need installed.
source 'https://rubygems.org'

# Ensures the corrrect version of rails 
# is used.
gem 'rails', '3.2.12'

# Bootstrap wil be used to prepare page
# layout. The sass will convert the native
# less-css format bootstrap uses to the rails
# sass format.
gem 'bootstrap-sass', '2.1'

# Gemfile for encrypting password to create password hash
gem 'bcrypt-ruby', '3.0.1'

# Gem to help gemerate users
gem 'faker', '1.0.1'

# Group that is only used when in
# development and test environments
group :development, :test do
	# Development and test databse management
	# system.
	gem 'sqlite3', '1.3.5'

	# Test suite for thei application
	gem 'rspec-rails', '2.11.0'

	# Factory generator
	gem 'factory_girl_rails', '4.1.0'	
end

# Group of gemfiles that will only be
# used when in development environment.
group :development do
	# Generates the attributes tied to a model
	gem 'annotate', '2.5.0'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	# Gem for SCSS and CSS files
	gem 'sass-rails', '3.2.5'

	# Gem for coffescripts
	gem 'coffee-rails', '3.2.2'

	# Gem for minimizing production files
	gem 'uglifier', '1.2.3'
end

# Gem for jquery
gem 'jquery-rails', '2.0.2'

# Group of gems that only runs when rails
# is in test environments
group :test do
	# Human like language for testing
	gem 'capybara', '1.1.2'
end

# Group of gems that only runs whe rails
# is in production environments
group :production do
	# Databse management system for
	# production environment (heroku)
	gem 'pg', '0.12.2'
end