FactoryBot.define do
  factory :property do
    name { "MyString" }
    headline { "MyString" }
    description { "MyText" }
    city { Faker::Address.city}
    country { Faker::Address.country}
    address_1 { Faker::Address.street_address}
  end
end
