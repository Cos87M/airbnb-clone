class PasswordsController < ApplicationController
  # Ensure the user is authenticated before accessing any actions in this controller
  before_action :authenticate_user!

  def show
    # Find the user by ID from the parameters
    @user = User.find(params[:id])
    # Authorize the user using the PasswordPolicy
    authorize @user, policy_class: PasswordPolicy
  end

  def update
    # Find the user by ID from the parameters
    @user = User.find(params[:id])
    # Authorize the user using the PasswordPolicy
    authorize @user, policy_class: PasswordPolicy
    # Update the user's password with the provided parameters
    if @user.update(password_params)
      # Display a flash message indicating the password was updated
      flash[:notice] = "Your password was updated: '#{password_params[:password]}'"
    end
    # Sign in the user again to refresh the session
    bypass_sign_in(@user)
    # Store the updated link ID in the session
    session[:active_link_id] = "password"
    # Redirect to the user's profile page
    redirect_to profile_path(@user)
  end

  private

  def password_params
    # Permit only the password parameter from the request
    params.require(:password).permit(:password)
  end
end
