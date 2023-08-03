RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }
  let(:profile) { user.profile }

  before { sign_in user }

  describe "GET /show" do
    it "succeeds" do
      get profile_path(profile)
      expect(response).to be_successful
    end
  end

  describe "PUT update" do
    it "succeeds" do
      profile.update! first_name: "Foo", last_name: "Bar"

      put profile_path(profile),params: {
        profile: {
          first_name: "Peteco"
        }
      }
      expect(profile.reload.first_name).to eq("Peteco")
      expect(response).to be_redirect
    end
  end
end
