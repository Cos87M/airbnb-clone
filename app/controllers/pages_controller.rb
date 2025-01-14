class PagesController < ApplicationController
  def home
    # Retrieve all properties to be displayed on the home page
    @properties = Property.all
  end
end
