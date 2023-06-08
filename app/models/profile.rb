class Profile < ApplicationRecord
  belongs_to :user

  geocoded_by :address
  after_validation :geocode, if: -> { address.blank? && longitude.blank? }

  def address
    [address_1, address_2, city, zip_code, country].compact.join(', ')
  end
end
