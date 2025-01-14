class ProfilesController < ApplicationController
  before_action :authenticate_user! # Ensure the user is authenticated before accessing any action in this controller

  def show
    @profile = Profile.find(params[:id]) # Find the profile by the ID provided in the parameters
    @user = current_user # Get the currently logged-in user
    @payments = current_user.payments # Get the payments associated with the current user
    authorize @profile # Authorize the profile for the current user
  end

  def update
    @profile = current_user.profile # Get the profile associated with the current user
    authorize @profile # Authorize the profile for the current user
    if @profile.update(profile_params) # Update the profile with the permitted parameters
      updated_fields = extract_updated_fields(profile_params) # Extract the fields that were updated
      flash[:notice] = "Your profile was updated: #{format_updated_fields(updated_fields)}" # Set a flash notice with the updated fields
    end
    session[:active_link_id] = "profile" # Store the updated link ID in the session
    redirect_to profile_path(current_user.profile) # Redirect to the profile page of the current user
  end

  private

  def profile_params
    params.require(:profile).permit(
      :first_name, :last_name, :address_1, :address_2,
      :city, :country_code, :zip_code, :picture
    ) # Permit only the specified parameters for the profile
  end

  def format_updated_fields(updated_fields)
    updated_fields.map { |field, value| "#{field.to_s.humanize}: '#{value}'" }.join(", ") # Format the updated fields for display
  end

  def extract_updated_fields(params, prefix = nil)
    updated_fields = {}
    params.each do |key, value|
      full_key = prefix ? "#{prefix}.#{key}" : key.to_s
      if value.is_a?(Hash)
        updated_fields.merge!(extract_updated_fields(value, full_key)) # Recursively extract fields if the value is a hash
      else
        updated_fields[full_key] = value if value.present? # Add the field to the updated fields if it has a value
      end
    end
    updated_fields
  end
end
