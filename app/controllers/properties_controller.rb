class PropertiesController < ApplicationController
  def show
    @property = Property.find_by(id: params[:id])
    if @property.nil?
      flash[:alert] = "Property not found."
      redirect_to property_path
      return
    end
    @reviews = Review.where(reviewable_id: @property.id, reviewable_type: "Property")
  end
end
