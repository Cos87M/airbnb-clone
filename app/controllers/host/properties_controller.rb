class Host::PropertiesController < ApplicationController
  before_action :authenticate_user!

  def new
    authorize current_user, policy_class: HostPolicy
    @property = Property.new(user: current_user)
  end

  def create
    authorize current_user, policy_class: HostPolicy
    @property = current_user.properties.new(property_params)

    if @property.save
      # Upload main image to Cloudinary
      @property.main_image.attach(params[:property][:main_image])

      # Upload secondary images to Cloudinary
      params[:property][:secondary_images].each do |image|
        @property.secondary_images.attach(image)
      end
        redirect_to host_dashboard_path
    else
      render :new
    end
  end

  private

  def property_params
    params.  require(:property).permit(
    :name, :headline, :description, :images, :address_1, :address_2, :city, :country_code, :zip_code
    )
  end
end
