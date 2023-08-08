require 'rails_helper'

RSpec.describe "PaymentsSidebars", type: :request do
  let(:user) { create(:user) }
  let(:reservation_payments)  { create_list(:payment, 3, user: user) }

  before { sign_in user }

  describe "GET /index" do
    it "succeeds" do
      get payments_sidebar_index_path
      expect(response).to be_successful
    end
  end
end
