class Host::PaymentsController < ApplicationController
  before_action :authenticate_user! # Ensure the user is authenticated before accessing any actions

  def index
    authorize current_user, policy_class: HostPolicy # Authorize the current user using HostPolicy
    @payments = current_user.receiving_payments.includes(reservation: :property) # Retrieve the payments received by the current user, including associated reservations and properties
  end
end
