require 'rails_helper'

RSpec.describe "PropertyReservations", type: :request do
  let(:property) { create(:property) }
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /new" do
    it "succeeds" do
      get new_property_reservation_path(property), params: {
        checkin_date: "28/07/2023",
        checkout_date: "28/08/2023",
      }
    end
  end
end
