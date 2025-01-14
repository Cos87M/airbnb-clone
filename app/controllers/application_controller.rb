class ApplicationController < ActionController::Base
  # Include Pundit for authorization
  include Pundit::Authorization
end
