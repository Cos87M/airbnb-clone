require 'rails_helper'

RSpec.describe "PropertyReservations", type: :request do
  let(:property) { create(:property) }
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /new" do
    it "succeeds" do
      get new_property_reservation_path(property)
    end
  end
end
