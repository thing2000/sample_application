class MicropostsController < ApplicationController
  
  # If user is not signed in redirect them to signin page.
  # It will only be applied to create and destroy actions.
  before_filter :signed_in_user, only: [:create, :destroy]

  def index
  end

  def create
  end

  def destroy
  end
end