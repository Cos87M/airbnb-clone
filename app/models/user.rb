class User < ApplicationRecord
  # Include default devise modules for authentication and user management
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Association with Profile model, a user has one profile
  has_one :profile, dependent: :destroy

  # Association with Favorite model, a user can have many favorites
  has_many :favorites, dependent: :destroy
  has_many :favorited_properties, through: :favorites, source: :property

  # Association with Reservation model, a user can have many reservations
  has_many :reservations, dependent: :destroy

  # Association with Payment model through reservations
  has_many :payments, through: :reservations

  # Association with Property model through reservations
  has_many :reserved_properties, through: :reservations, source: :property

  # Association with Review model, a user can have many reviews
  has_many :reviews, dependent: :destroy

  # Association with Property model, a user can have many properties
  has_many :properties, dependent: :destroy

  # Association with Payment model through properties
  has_many :receiving_payments, through: :properties, source: :payments

  # Define possible roles for a user
  ROLES = %w[host]

  # Validate that the role is included in the defined roles, allow nil values
  validates :role, inclusion: { in: ROLES }, allow_nil: true

  # Callback to create a profile after a user is created
  after_create :create_profile
  def create_profile
    self.profile = Profile.new
    save!
  end

  # Delegate the full_name method to the profile
  delegate :full_name, to: :profile

  # Check if the user is a host
  def host?
    role == "host"
  end

  # Set the user's role to host
  def hostify!
    puts "hostify! method called"
    update!(role: "host")
  end

  # Check if the user is a customer (no role assigned)
  def customer?
    role.blank?
  end
end
