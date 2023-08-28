# require 'rails_helper'

# RSpec.describe "Host::Properties", type: :request do
#   let(:user) { create(:user, role: "host") }
#   let(:property) { create(:property, user: user) }

#   before { sign_in user }

#   describe "GET new" do
#     it "succeeds" do
#       get new_host_property_path
#       expect(response).to be_successful
#     end
#   end

#   describe "POST create" do
#     context "valid params" do
#       it "succeeds and creates a new property" do
#         main_image_url = "https://res.cloudinary.com/dnmf6p8tj/image/upload/v1692899529/airbnb-clone/property_1.jpg"
#         secondary_image_urls = [
#           "https://res.cloudinary.com/dnmf6p8tj/image/upload/v1692899529/airbnb-clone/property_1_secondary_1.jpg",
#           "https://res.cloudinary.com/dnmf6p8tj/image/upload/v1692899529/airbnb-clone/property_1_secondary_2.jpg"
#         ]

#         expect do
#           post host_properties_path, params: {
#             property: {
#               name: "new property name",
#               headline: "headline",
#               description: "description",
#               address_1: "address_1",
#               address_2: "address_2",
#               city: "Mainz",
#               country_code: "DE",
#               zip_code: "55116",
#               main_image: main_image_url,
#               secondary_images: secondary_image_urls
#             }
#           }
#         end.to change { Property.count }.by(1)

#         expect(response).to be_redirect
#       end
#     end

#     context "invalid params" do
#       it "fails and does not create a new property" do
#         expect do
#           post host_properties_path, params: {
#             property: {
#               name: "new property name"
#             }
#           }
#         end.not_to(change { Property.count })

#         expect(response).to be_successful
#       end
#     end
#   end
# end
