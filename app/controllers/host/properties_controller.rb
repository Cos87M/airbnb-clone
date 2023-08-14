class Host::PropertiesController < ApplicationController
  before_action :authenticate_user!

  def new
    authorize current_user, policy_class: HostPolicy
  end
end
