class FavoriteSerializer
  include JSONAPI::Serializer

  # Define the attributes to be serialized
  attributes :id, :user_id, :property_id

  # Define any other attributes you want to include in the serialized output
end
