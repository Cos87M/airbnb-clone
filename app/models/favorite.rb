class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates_uniqueness_of :property_id, scope: :user_id
end
