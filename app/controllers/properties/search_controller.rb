class Properties::SearchController < ApplicationController
  # The index action retrieves all properties and applies filters based on search parameters
  def index
    @properties = Property.all

    # Apply filters to the properties based on city, country code, and date range
    filter_by_city
    filter_by_country_code
    filter_by_date_range

    # Build an array of markers for properties with geocoded locations
    @markers = @properties.geocoded.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude
      }
    end
  end

  private

  # Filter properties by city if the city parameter is present
  def filter_by_city
    return unless search_params[:city].present?
    @properties = @properties.city(search_params[:city])
  end

  # Filter properties by country code if the country code parameter is present
  def filter_by_country_code
    return unless search_params[:country_code].present?
    @properties = @properties.country_code(search_params[:country_code])
  end

  # Filter properties by date range if both checkin and checkout dates are present
  def filter_by_date_range
    return unless search_params[:checkin_date] && search_params[:checkout_date]

    # Get properties that have reservations within the specified date range
    properties_with_reservations = Property.with_reservations_between_dates(
      search_params[:checkin_date],
      search_params[:checkout_date]
    )

    # Exclude properties that have reservations within the specified date range
    @properties = @properties.where.not(id: properties_with_reservations)
  end

  # Permit only the allowed search parameters
  def search_params
    params.permit(:city, :country_code, :checkin_date, :checkout_date, :commit)
  end
end
