class Profile < ApplicationRecord

  belongs_to :user

  has_one_attached :picture

  geocoded_by :address
  after_validation :geocode, if: -> { address.blank? && longitude.blank? }

  def address
    [address_1, address_2, city, zip_code, country_name].compact.join(', ')
  end

  def full_name
    "#{first_name} #{last_name}".squish
  end

  def country_name
    country = ISO3166::Country[country_code]
    if country.nil?
      "Unknown Country" # Or any default value you prefer
    else
      country.translations[I18n.locale.to_s] || country.name
    end
  end
end
