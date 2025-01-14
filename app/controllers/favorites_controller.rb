class FavoritesController < ApplicationController
  # Disable CSRF protection for this controller
  protect_from_forgery with: :null_session

  # Create a new favorite or find an existing one
  def create
    favorite = Favorite.find_or_create_by(favorite_params) # Find or create a favorite with the provided parameters

    respond_to do |format|
      format.json do
        render json: serialize_favorite(favorite), status: :created # Render the favorite as JSON with a created status
      end
    end
  end

  # Destroy an existing favorite
  def destroy
    favorite = Favorite.find(params[:id]) # Find the favorite by the provided id parameter
    favorite.destroy! # Destroy the favorite

    respond_to do |format|
      format.json do
        render json: serialize_favorite(favorite), status: 204 # Render the favorite as JSON with a no content status
      end
    end
  end

  private

  # Strong parameters for favorite creation
  def favorite_params
    params.require(:favorite).permit(:user_id, :property_id) # Permit only the user_id and property_id parameters
  end

  # Serialize the favorite object to JSON
  def serialize_favorite(favorite)
    FavoriteSerializer.new(favorite).serializable_hash.to_json # Use the FavoriteSerializer to serialize the favorite
  end
end
