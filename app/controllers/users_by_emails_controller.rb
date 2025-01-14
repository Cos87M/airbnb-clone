# frozen_string_literal: true

class UsersByEmailsController < ApplicationController
  def show
    # Find the user by email
    user = User.find_by!(email: params[:email])

    # Respond with the user data in JSON format
    respond_to do |format|
      format.json do
        render json: user.to_json, status: :ok
      end
    end

  rescue ActiveRecord::RecordNotFound => e
    # Handle the case where the user is not found
    respond_to do |format|
      format.json do
        render json: { error: e.message }.to_json, status: 404
      end
    end
  end
end
