class ReservationPaymentsController < ApplicationController
  def create
    # Create a new Stripe card source for the customer
    stripe_card = Stripe::Customer.create_source(
      stripe_customer.id,
      { source: payment_params[:stripeToken] }
    )

    # Create a new Stripe charge
    charge = Stripe::Charge.create(
      amount: Money.from_amount(BigDecimal(payment_params[:total])).cents,
      currency: "eur",
      source: stripe_card.id,
      customer: stripe_customer.id
    )

    # Create a new reservation
    reservation = Reservation.create(
      property: property,
      user: user,
      checkin_date: Date.strptime(payment_params[:checkin_date], "%m/%d/%Y"),
      checkout_date: Date.strptime(payment_params[:checkout_date], "%m/%d/%Y")
    )

    # Create a new payment record
    Payment.create(
      reservation: reservation,
      subtotal: Money.from_amount(BigDecimal(payment_params[:subtotal])),
      cleaning_fee: Money.from_amount(BigDecimal(payment_params[:cleaning_fee])),
      service_fee: Money.from_amount(BigDecimal(payment_params[:service_fee])),
      total: Money.from_amount(BigDecimal(payment_params[:total])),
      stripe_id: charge.id
    )

    # Redirect to the homepage after successful payment and reservation creation
    redirect_to root_path
  end

  private

  # Strong parameters for payment
  def payment_params
    params.permit(
      :stripeToken,
      :property_id,
      :user_id,
      :checkin_date,
      :checkout_date,
      :subtotal,
      :cleaning_fee,
      :service_fee,
      :total
    )
  end

  # Find the property based on the property_id parameter
  def property
    @property ||= Property.find(payment_params[:property_id])
  end

  # Find the user based on the user_id parameter
  def user
    @user ||= User.find(payment_params[:user_id])
  end

  # Retrieve or create a Stripe customer for the user
  def stripe_customer
    @stripe_customer ||= if user.stripe_id.blank?
                           customer = Stripe::Customer.create(email: user.email)
                           user.update(stripe_id: customer.id)
                           customer
                         else
                           Stripe::Customer.retrieve(user.stripe_id)
                         end
  end
end
