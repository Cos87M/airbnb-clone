class Review < ApplicationRecord
  # Validates presence of title and body for a review
  validates :title, :body, presence: true
  
  # Validates presence and numericality of rating, ensuring it is an integer between 1 and 5
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true }

  # Establishes a polymorphic relationship indicating that a review belongs to a reviewable entity (e.g., property, user)
  belongs_to :reviewable, polymorphic: true, counter_cache: true
  
  # Establishes a relationship indicating that each review belongs to a user
  belongs_to :user

  # After a review is created or updated, update the average rating of the reviewable entity
  after_commit :update_average_rating, on: [:create, :update]

  # Method to update the average rating of the reviewable entity
  def update_average_rating
    reviewable.update!(average_rating: reviewable.reviews.average(:rating))
  end
end
