class Properties::SearchController < ApplicationController
  def index
    @properties = Property.all

    filter_by_city
    filter_by_country_code
    filter_by_date_range

    # preload_reservations_for_properties
    # collect_reservation_dates
  end

  private

  def filter_by_city
    return unless search_params[:city].present?
    @properties = @properties.city(search_params[:city])
  end

  def filter_by_country_code
    return unless search_params[:country_code].present?
    @properties = @properties.country_code(search_params[:country_code])
  end

  # def filter_by_date_range

  #   # filter the properties have reservations
  #   return unless search_params[:checkin_date] && search_params[:checkout_date]

  #   properties_with_reservations = Property.joins(:reservations)
  #     .where("reservations.checkout_date >= ?", Date.strptime(search_params[:checkin_date], "%m/%d/%Y"))
  #     .where("reservations.checkin_date <= ?", Date.strptime(search_params[:checkout_date], "%m/%d/%Y"))

  #   @properties = @properties.where.not(id: properties_with_reservations)
  # end

  def filter_by_date_range
    return unless search_params[:checkin_date] && search_params[:checkout_date]

    properties_with_reservations = Property.with_reservations_between_dates(
      search_params[:checkin_date],
      search_params[:checkout_date]
    )

    @properties = @properties.where.not(id: properties_with_reservations)
  end


  # def preload_reservations_for_properties
  #   @properties = @properties.includes(:reservations)
  # end

  # def collect_reservation_dates
  #   @reservations_dates = {}
  #   @properties.each do |property|
  #     reservation_dates = property.reservations.pluck(:checkin_date, :checkout_date)
  #     @reservations_dates[property.id] = reservation_dates
  #   end
  # end

  def search_params
    params.permit(:city, :country_code, :checkin_date, :checkout_date, :commit)
  end
end
