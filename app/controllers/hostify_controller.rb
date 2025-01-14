class HostifyController < ApplicationController
  # Ensure the user is authenticated before accessing any actions in this controller
  before_action :authenticate_user!

  # Update the user to become a host
  def update
    user = User.find(params[:user_id]) # Find the user by the provided user_id parameter
    user.hostify! # Call the hostify! method on the user to make them a host
    redirect_back(fallback_location: root_path) # Redirect back to the previous page or root path if no referrer
  end
end
