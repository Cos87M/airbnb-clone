class Host::PropertiesController < ApplicationController
  before_action :authenticate_user! # Ensure the user is authenticated before accessing any actions

  def new
    authorize current_user, policy_class: HostPolicy # Authorize the current user using HostPolicy
    @property = Property.new(user: current_user) # Initialize a new Property object associated with the current user
  end

  def create
    authorize current_user, policy_class: HostPolicy # Authorize the current user using HostPolicy
    @property = current_user.properties.new(property_params) # Create a new property with the provided parameters

    if @property.save
      # Upload main image to Cloudinary
      @property.main_image.attach(params[:property][:main_image])

      # Upload secondary images to Cloudinary
      params[:property][:secondary_images].each do |image|
        @property.secondary_images.attach(image)
      end
      redirect_to host_dashboard_path # Redirect to the host dashboard if the property is successfully saved
    else
      render :new # Render the new property form again if saving fails
    end
  end

  private

  def property_params
    params.require(:property).permit(
      :name, :headline, :description, :images, :address_1, :address_2, :city, :country_code, :zip_code
    ) # Permit only the allowed parameters for a property
  end
end
