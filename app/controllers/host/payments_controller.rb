class Host::PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize current_user, policy_class: HostPolicy
    @payments = current_user.receiving_payments.includes(reservation: :property)
  end

end
