# frozen_string_literal: true

class Property < ApplicationRecord
  # Validates presence of essential attributes for a property
  validates :name, :headline, :description, :city, :country_code, :address_1, presence: true

  # Adds methods to handle money values for price, allowing nil values
  monetize :price_cents, allow_nil: true

  # Sets up geocoding by address
  geocoded_by :address
  
  # Geocodes the address after validation if latitude and longitude are blank
  after_validation :geocode, if: -> { latitude.blank? && longitude.blank? }

  # Establishes a relationship indicating that each property belongs to a user
  belongs_to :user
  
  # Adds functionality to attach multiple secondary images to the property
  has_many_attached :secondary_images, dependent: :destroy
  
  # Adds functionality to attach a main image to the property
  has_one_attached :main_image, dependent: :destroy

  # This association allows the Property model to have multiple reviews associated with it
  has_many :reviews, as: :reviewable
  
  # Establishes a relationship indicating that a property can have many favorites
  has_many :favorites, dependent: :destroy
  
  # Establishes a relationship to get users who favorited the property through favorites
  has_many :favorited_users, through: :favorites, source: :user

  # Establishes a relationship indicating that a property can have many reservations
  has_many :reservations, dependent: :destroy
  
  # Establishes a relationship to get users who reserved the property through reservations
  has_many :reserved_users, through: :reservations, source: :user

  # Establishes a relationship to get payments through reservations
  has_many :payments, through: :reservations

  # Constants for cleaning fee and service fee percentage
  CLEANING_FEE = 2_500.freeze
  CLEANING_FEE_MONEY = Money.new(CLEANING_FEE)
  SERVICE_FEE_PERCENTAGE = (0.1).freeze

  # Scopes to filter properties by city and country code
  scope :city, ->(city) { where("lower(city) like ?", "%#{city.downcase}%") }
  scope :country_code, ->(country_code) { where("lower(country_code) like ?", "%#{country_code.downcase}%") }

  # It will return a collection of properties that are booked within the specified date range
  scope :with_reservations_between_dates, ->(checkin, checkout) do
    joins(:reservations)
      .where("reservations.checkout_date >= ?", Date.strptime(checkin, "%m/%d/%Y"))
      .where("reservations.checkin_date <= ?", Date.strptime(checkout, "%m/%d/%Y"))
  end

  # Combines address components into a single string
  def address
    # [address_1, address_2, city, country_name].compact.join(', ')
    [city, country_name].compact.join(', ')
  end

  # Checks if the property is favorited by a specific user
  def favorited_by?(user)
    return if user.nil?

    favorited_users.include?(user)
  end

  # Returns available dates for the property
  def available_dates
    date_format = "%b %e"
    next_reservation = reservations.future_reservations.order(checkout_date: :desc).first

    return Date.tomorrow.strftime(date_format)..Date.today.end_of_year.strftime(date_format) if next_reservation === nil

    next_reservation.checkout_date.strftime(date_format)..Date.today.end_of_year.strftime(date_format)
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
