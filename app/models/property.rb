class Property < ApplicationRecord
  validates :name, :headline, :description, :city, :country, :address_1, presence: true


  geocoded_by :address
  after_validation :geocode, if: -> { latitude.blank? && longitude.blank? }

  def address
    # [address_1, address_2, city, country].compact.join(', ')
    [ city, country].compact.join(', ')

  end
end
