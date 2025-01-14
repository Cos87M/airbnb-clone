class Reservation < ApplicationRecord
  # Establishes a relationship indicating that each reservation belongs to a property
  belongs_to :property
  
  # Establishes a relationship indicating that each reservation belongs to a user
  belongs_to :user

  # Adds a dependent relationship indicating that a reservation has one payment, which will be destroyed if the reservation is destroyed
  has_one :payment, dependent: :destroy

  # Validates presence of check-in date
  validates :checkin_date, presence: true
  
  # Validates presence of check-out date
  validates :checkout_date, presence: true

  # Scope to get future reservations where the checkout date is after today
  scope :future_reservations, -> { where("checkout_date > ?", Date.today) }
end
