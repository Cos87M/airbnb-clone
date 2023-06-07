class Property < ApplicationRecord
  validates :name, :headline, :description, :city, :country, :address_1, presence: true

end
