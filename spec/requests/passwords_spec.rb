require 'rails_helper'
require 'devise'


RSpec.describe "Passwords", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /show" do
    it "succeeds" do
      get password_path(user)
      expect(response).to be_successful
    end
  end

  describe "PUT update" do
    it "succeeds" do
      user.update! password: "123456"
      new_password = "password123!"

      put password_path(user), params: {
        password: {
          password: new_password
        }
      }
      expect(user.reload.valid_password?(new_password)).to eq(true)

      expect(response).to be_redirect
    end
  end
end
