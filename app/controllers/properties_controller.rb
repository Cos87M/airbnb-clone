class PropertiesController < ApplicationController
  def show
    @property = Property.find(params[:id])
    @reviews = Review.where(reviewable_id: @property.id, reviewable_type: "Property")
  end
end
