class StaticPagesController < ApplicationController
  
  # Controller class for home page
  def home
    if signed_in?
      # Builds the micropost for current user and assign it to
      # instance variable @micropost.
      @micropost = current_user.microposts.build

      # Builds the micropost for current user based on their feed attribute
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
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
