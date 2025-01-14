class Favorite < ApplicationRecord
  # Establishes a relationship indicating that each favorite belongs to a user
  belongs_to :user
  
  # Establishes a relationship indicating that each favorite belongs to a property
  belongs_to :property

  # Ensures that a user can only favorite a specific property once
  validates_uniqueness_of :property_id, scope: :user_id
end
