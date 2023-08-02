RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }
  let(:profile) { user.profile }

  before { sign_in user }

  describe "PUT update" do
    it "succeeds" do
      # Set initial state for profile
      profile.update!(first_name: nil, last_name: nil)

      # puts "Before update: #{profile.first_name} #{profile.last_name}"

      expect {
        put profile_path(profile), params: {
          profile: {
            first_name: "Pet",
            last_name: "Smith"
          }
        }
      }.to change { profile.reload.first_name }.from(nil).to("Pet")
       .and change { profile.reload.last_name }.from(nil).to("Smith")

      puts "After update: #{profile.reload.first_name} #{profile.reload.last_name}"

      expect(response).to be_redirect
    end
  end
end
