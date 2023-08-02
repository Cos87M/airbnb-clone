FactoryBot.define do
  factory :profile do
    user { nil }
    city { Faker::Address.city}
    country_code { Faker::Address.country_code}
    address_1 { Faker::Address.street_address}
    latitude { 1.5 }
    longitude { 1.5 }
  end
end
