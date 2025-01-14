class PropertiesController < ApplicationController
  # Action to show a specific property
  def show
    # Find the property by id from the parameters
    @property = Property.find_by(id: params[:id])
    
    # If the property is not found, set an alert message and redirect to the property path
    if @property.nil?
      flash[:alert] = "Property not found."
      redirect_to property_path
      return
    end
    
    # Fetch all reviews associated with the property
    @reviews = Review.where(reviewable_id: @property.id, reviewable_type: "Property")
  end
end
