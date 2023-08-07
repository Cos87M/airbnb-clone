class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    authorize @user, policy_class: AccountPolicy
  end

  def update
    @user = User.find(params[:id])
    authorize @user, policy_class: AccountPolicy
    if @user.update(account_params)
      flash[:notice] = "Your email was updated: #{params[:account][:email]}"
    end
    session[:active_link_id] = "account" # Store the updated link ID in the session
    redirect_to profile_path(@user)
  end

  private

  def account_params
    params.require(:account).permit(:email)
  end
end
