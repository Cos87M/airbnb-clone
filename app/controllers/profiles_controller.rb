class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = Profile.find(params[:id])
    @user = current_user
    authorize @profile
  end

  def update
    @profile = current_user.profile
    authorize @profile
    if @profile.update(profile_params)
      updated_fields = extract_updated_fields(profile_params)
      flash[:notice] = "Your profile was updated: #{format_updated_fields(updated_fields)}"
    end
    session[:active_link_id] = "profile" # Store the updated link ID in the session
    redirect_to profile_path(current_user.profile) # Use current_user.profile here
  end

  private

  def profile_params
    params.require(:profile).permit(
      :first_name, :last_name, :address_1, :address_2,
      :city, :country_code, :zip_code, :picture
    )
  end

  def format_updated_fields(updated_fields)
    updated_fields.map { |field, value| "#{field.to_s.humanize}: '#{value}'" }.join(", ")
  end

  def extract_updated_fields(params, prefix = nil)
    updated_fields = {}
    params.each do |key, value|
      full_key = prefix ? "#{prefix}.#{key}" : key.to_s
      if value.is_a?(Hash)
        updated_fields.merge!(extract_updated_fields(value, full_key))
      else
        updated_fields[full_key] = value if value.present?
      end
    end
    updated_fields
  end
end
