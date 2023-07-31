require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /show" do
    let(:user) { create(:user) }
    let(:profile) { user.profile }

    before { sign_in user }

    it "succeds" do
      get profile_path(profile)
      expect(response).to be_successful
    end
  end
end
