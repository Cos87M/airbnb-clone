module Host
  class DashboardController < ApplicationController
    # Ensure the user is authenticated before any action
    before_action :authenticate_user!

    # The index action is the main action for the dashboard
    def index
      # Authorize the current user using the HostPolicy
      authorize current_user, policy_class: HostPolicy
      # Fetch the properties associated with the current user
      @properties = current_user.properties
    end
  end
end