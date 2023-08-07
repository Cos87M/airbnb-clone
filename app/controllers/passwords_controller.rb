class PasswordsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    authorize @user, policy_class: PasswordPolicy
  end

  def update
    @user = User.find(params[:id])
    authorize @user, policy_class: PasswordPolicy
    if @user.update(password_params)
      flash[:notice] = "Your password was updated: '#{password_params[:password]}'"
    end
    bypass_sign_in(@user)
    session[:active_link_id] = "password" # Store the updated link ID in the session
    redirect_to profile_path(@user)
  end

  private

  def password_params
    params.require(:password).permit(:password)
  end
end
