require 'rails_helper'

RSpec.describe "UsersByEmails", type: :request do
  describe "GET /show" do

    context "user exists" do
      it "is successful" do
        user = create(:user)
        get users_by_email_path, params: { email: user.email }, headers: {'ACCEPT' => 'application/json'}
        expect(response).to be_successful
      end
    end
    context"user does not exist" do
      it "is not found" do
        get users_by_email_path, params: { email: "junk@example.com" }, headers: {'ACCEPT' => 'application/json'}
        expect(response.status).to eq(404)
      end
    end
  end
end
