class Properties::SearchController < ApplicationController
  def index
    @properties = Property.all

    if search_params[:city].present?
      @properties = @properties.city(search_params[:city])
    end

    if search_params[:country_code].present?
      @properties = @properties.country_code(search_params[:country_code])
    end

   # Find properties without any reservations at all
    properties_without_reservations = @properties.includes(:reservations).select { |property| property.reservations.size.zero? }

    #  Find properties with no reservations within the selected date range
    if search_params[:checkin_date] && search_params[:checkout_date]
      @properties = @properties.between_dates(search_params[:checkin_date], search_params[:checkout_date])
    end

    @properties = Property.where(id: properties_without_reservations.map(&:id) + @properties.ids)


    # List reservations dates for each property
    # Collect reservation dates for filtered properties
    @reservations_dates = {}
    @properties.each do |property|
      reservation_dates = property.reservations.pluck(:checkin_date, :checkout_date)
      @reservations_dates[property.id] = reservation_dates
    end
  end

  private

  def search_params
    params.permit(:city, :country_code, :checkin_date, :checkout_date, :commit)
  end
end
