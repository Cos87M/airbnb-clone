class Profile < ApplicationRecord

  # Establishes a relationship indicating that each profile belongs to a user
  belongs_to :user

  # Adds functionality to attach a picture to the profile
  has_one_attached :picture

  # Sets up geocoding by address
  geocoded_by :address
  
  # Geocodes the address after validation if address and longitude are blank
  after_validation :geocode, if: -> { address.blank? && longitude.blank? }

  # Combines address components into a single string
  def address
    [address_1, address_2, city, zip_code, country_name].compact.join(', ')
  end

  # Combines first and last name into a full name string
  def full_name
    "#{first_name} #{last_name}".squish
  end

  # Retrieves the country name based on the country code
  def country_name
    country = ISO3166::Country[country_code]
    if country.nil?
      "Unknown Country" # Or any default value you prefer
    else
      country.translations[I18n.locale.to_s] || country.name
    end
  end
end
