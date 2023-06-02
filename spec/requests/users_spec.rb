require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /show" do

    context "user exists" do
      it "is successful" do
        user = create(:user)
        get user_path(user), headers: {'ACCEPT' => 'application/json'}
        expect(response).to be_successful
      end
    end
    context"user does not exist" do
      it "is not found" do
        get user_path(id: "junk"), headers: {'ACCEPT' => 'application/json'}
        expect(response.status).to eq(404)
      end
    end
  end
end
