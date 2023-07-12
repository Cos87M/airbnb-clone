class FavoritesController < ApplicationController

  protect_from_forgery with: :null_session


  def create
    favorite = Favorite.create!(favorite_params)

    respond_to do |format|
      format.json do
        render json: serialize_favorite(favorite), status: :created
      end
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy!

    respond_to do |format|
      format.json do
        render json: serialize_favorite(favorite), status: 204
      end
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :property_id)
  end

  def serialize_favorite(favorite)
    FavoriteSerializer.new(favorite).serializable_hash.to_json
  end
end
