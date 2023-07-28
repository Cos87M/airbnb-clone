require 'rails_helper'

RSpec.describe "Properties", type: :request do
  describe "GET /show" do
    let(:property) { create(:property) }

    it "succeeds" do
      get "/properties/#{property.id}"
      expect(response).to be_successful
    end
  end
end
