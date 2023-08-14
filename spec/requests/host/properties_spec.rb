require 'rails_helper'

RSpec.describe "Host::Properties", type: :request do
  let(:user) { create(:user, role: "host") }

  before { sign_in user }

  describe "GET new" do
    it "succeeds" do
      get new_host_property_path
      expect(response).to be_successful
    end
  end
end
