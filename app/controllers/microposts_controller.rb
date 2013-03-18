class MicropostsController < ApplicationController
  
  # If user is not signed in redirect them to signin page.
  before_filter :signed_in_user, only: [:create, :destroy]

  # Filter to ensure user is owner of micropost
  before_filter :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy

    # Destroy the micropost
    @micropost.destroy

    # Redirect to homepage
    redirect_to root_url
  end

  private
    def correct_user

      # Search for micropost with id associated to current user
      @micropost = current_user.microposts.find_by_id(params[:id])

      # If there was not a micropost that matches return to homepage
      redirect_to root_url if @micropost.nil?
    end
end