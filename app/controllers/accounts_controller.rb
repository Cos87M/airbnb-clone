class AccountsController < ApplicationController
  # Ensure the user is authenticated before accessing any actions in this controller
  before_action :authenticate_user!

  # Show the account details of the user
  def show
    @user = User.find(params[:id]) # Find the user by the provided id parameter
    authorize @user, policy_class: AccountPolicy # Authorize the user using the AccountPolicy
  end

  # Update the account details of the user
  def update
    @user = User.find(params[:id]) # Find the user by the provided id parameter
    authorize @user, policy_class: AccountPolicy # Authorize the user using the AccountPolicy
    if @user.update(account_params) # Update the user with the permitted account parameters
      flash[:notice] = "Your email was updated: #{params[:account][:email]}" # Set a flash notice with the updated email
    end
    session[:active_link_id] = "account" # Store the updated link ID in the session
    redirect_to profile_path(@user) # Redirect to the user's profile page
  end

  private

  # Strong parameters for account update
  def account_params
    params.require(:account).permit(:email) # Permit only the email parameter for account update
  end
end
