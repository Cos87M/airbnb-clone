class PropertyReservationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @property = Property.find(params[:property_id])
    @reservation = @property.reservations.new
    @checkin_date = new_reservation_params[:checkindate]
    @checkout_date = new_reservation_params[:checkoutdate]
    @subtotal = new_reservation_params[:subtotal]
    @cleaning_fee = new_reservation_params[:cleaning_fee]
    @total = new_reservation_params[:total]
    @service_fee = new_reservation_params[:service_fee]
    @differenceInDays = new_reservation_params[:differenceInDays]

  end

  private

  def new_reservation_params
    params.permit(:checkindate, :checkoutdate, :subtotal, :cleaning_fee, :total, :service_fee, :property_id, :differenceInDays)
  end
end
