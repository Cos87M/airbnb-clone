class Property < ApplicationRecord
  validates :name, :headline, :description, :city, :country, :address_1, presence: true

  monetize :price_cents, allow_nil: true

  geocoded_by :address
  after_validation :geocode, if: -> { latitude.blank? && longitude.blank? }

  has_many_attached :images, dependent: :destroy

  def address
    # [address_1, address_2, city, country].compact.join(', ')
    [ city, country].compact.join(', ')
  end

  def default_image
    images.first
  end
end
