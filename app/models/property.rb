# frozen_string_literal: true

class Property < ApplicationRecord
  validates :name, :headline, :description, :city, :country, :address_1, presence: true

  monetize :price_cents, allow_nil: true

  geocoded_by :address
  after_validation :geocode, if: -> { latitude.blank? && longitude.blank? }

  has_many_attached :images, dependent: :destroy

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
  def address
    # [address_1, address_2, city, country].compact.join(', ')
    [city, country].compact.join(', ')
  end

  def default_image
    images.first
  end
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

end
