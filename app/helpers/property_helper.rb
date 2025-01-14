module PropertyHelper
  # This method calculates the percentage of reviews for a property that have a specific rating.
  def property_rating_percentage(property:, rating:)
    # Return 0 if the property has no reviews
    return 0 if property.reviews_count.zero?

    # Calculate the percentage of reviews with the specified rating
    ((property.reviews.where(rating: rating).size.to_f / property.reviews_count) * 100).to_i
  end
end
