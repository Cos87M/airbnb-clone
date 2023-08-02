class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @profile = current_user.profile
    # country_name = @profile.country_name
  end

  def update
    @profile = Profile.find(params[:id])
    # puts "Received params: #{params.inspect}"
    @profile.update(profile_params)
    # binding.pry
    redirect_to profile_path(@profile)
  end

  private

  def profile_params
    params.require(:profile).permit(
      :first_name, :last_name, :address_1, :address_2,
      :city, :country_code, :zip_code
    )
  end
end
