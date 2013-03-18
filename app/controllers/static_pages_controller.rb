class StaticPagesController < ApplicationController
  
  # Controller class for home page
  def home

    # Builds the micropost for current user and assign it to
    # instance variable @micropost.
    @micropost = current_user.microposts.build if signed_in?
  end

  # Controller class for the help page
  def help
  end

  # Controller class for the about page
  def about
  end

  # Controller class for the contact page
  def contact
  end
end
