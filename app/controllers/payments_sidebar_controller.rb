class PaymentsSidebarController < ApplicationController
  # Ensure the user is authenticated before accessing any actions in this controller
  before_action :authenticate_user!

  def index
    # Retrieve all payments associated with the currently logged-in user
    @payments = current_user.payments
  end
end
