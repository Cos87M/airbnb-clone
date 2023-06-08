# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Property.destroy_all

6.times do
  Property.create!(
    name: Faker::Lorem.unique.word,
    headline: Faker::Lorem.unique.sentence,
    description: Faker::Lorem.paragraph,
    address_1: Faker::Address.street_address,
    city: Faker::Address.city,
    country: "Germany",
    longitude: Faker::Address.longitude,
    latitude: Faker::Address.latitude,
  )
end
