class PropertyReservationsController < ApplicationController
  # Ensure the user is authenticated before allowing access to actions
  before_action :authenticate_user!

  # Action to initialize a new reservation
  def new
    # Find the property by id from the parameters
    @property = Property.find(params[:property_id])
    # Create a new reservation associated with the property
    @reservation = @property.reservations.new
    # Set reservation details from the parameters
    @checkin_date = new_reservation_params[:checkindate]
    @checkout_date = new_reservation_params[:checkoutdate]
    @subtotal = new_reservation_params[:subtotal]
    @cleaning_fee = new_reservation_params[:cleaning_fee]
    @total = new_reservation_params[:total]
    @service_fee = new_reservation_params[:service_fee]
    @differenceInDays = new_reservation_params[:differenceInDays]
  end

  private

  # Permit only the specified parameters for a new reservation
  def new_reservation_params
    params.permit(:checkindate, :checkoutdate, :subtotal, :cleaning_fee, :total, :service_fee, :property_id, :differenceInDays)
  end
end
