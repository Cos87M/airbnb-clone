# frozen_string_literal: true

class Property < ApplicationRecord
  validates :name, :headline, :description, :city, :country_code, :address_1, presence: true

  monetize :price_cents, allow_nil: true

  geocoded_by :address
  after_validation :geocode, if: -> { latitude.blank? && longitude.blank? }


  belongs_to :user
  has_many_attached :secondary_images, dependent: :destroy
  has_one_attached :main_image, dependent: :destroy

  # This association allows the Property model to have multiple reviews associated with it
  has_many :reviews, as: :reviewable
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :reservations, dependent: :destroy
  has_many :reserved_users, through: :reservations, source: :user

  has_many :payments, through: :reservations

  CLEANING_FEE = 2_500.freeze
  CLEANING_FEE_MONEY = Money.new(CLEANING_FEE)
  SERVICE_FEE_PERCENTAGE = (0.1).freeze

  scope :city, ->(city) { where("lower(city) like ?", "%#{city.downcase}%") }
  scope :country_code, ->(country_code) { where("lower(country_code) like ?", "%#{country_code.downcase}%") }

  # It will return a collection of properties that are booked within the specified date range
  scope :with_reservations_between_dates, ->(checkin, checkout) do
    joins(:reservations)
      .where("reservations.checkout_date >= ?", Date.strptime(checkin, "%m/%d/%Y"))
      .where("reservations.checkin_date <= ?", Date.strptime(checkout, "%m/%d/%Y"))
  end


  def address
    # [address_1, address_2, city, country_name].compact.join(', ')
    [city, country_name].compact.join(', ')
  end

  # def main_image
  #   images.find_by(name: "property_#{self.id}_main_image.jpg")
  # end

  # def secondary_images
  #   images.select { |image| image.name.to_s.match?(/^property_#{self.id}_secondary_\d+\.jpg$/) }
  # end

  def favorited_by?(user)
    return if user.nil?

    favorited_users.include?(user)
  end

  def available_dates
    date_format = "%b %e"
    next_reservation = reservations.future_reservations.order(checkout_date: :desc).first

    return Date.tomorrow.strftime(date_format)..Date.today.end_of_year.strftime(date_format) if next_reservation === nil

    next_reservation.checkout_date.strftime(date_format)..Date.today.end_of_year.strftime(date_format)
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
