# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Property.destroy_all
User.destroy_all
Review.destroy_all

user_pictures = []

# 6.times do
#   user_pictures << URI.parse(Faker::LoremFlickr.unique.image(size: "50x60")).open
# end

me = User.create!(email: 'peteco@gmail.com', password: '123456')

me.profile.update(first_name: 'Pet', last_name: 'Eco', country_code: "DE")
image_path = Rails.root.join('db', 'sample_images', "user_6.jpg")

me.profile.picture.attach(io: File.open(image_path), filename: "#{me.full_name}.jpg")

# me.picture.attach(io: user_pictures[0], filename: "#{me.full_name.jpg}")

# 5.times do
#   user = User.create!(email: Faker::Internet.email, password: '123456', first_name: Faker::Name.first_name, last_name: Faker::Name.last_name )
#   # user.picture.attach(io: user_pictures[i + 1], filename: "#{user.full_name.jpg}")
# end

# Create users using Faker data
5.times do |i|

  email = Faker::Internet.email
  password = '123456' # Set a default password for all users

  user = User.create!(
    email: email,
    password: password
  )
  user.profile.update(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  # Attach a profile picture to each user
  image_path = Rails.root.join('db', 'sample_images', "user_#{i + 1}.jpg")
  user.profile.picture.attach(io: File.open(image_path), filename: "#{user.full_name}.jpg")
end

8.times do |i|
  property = Property.create!(
    name: Faker::Lorem.unique.word,
    headline: Faker::Lorem.unique.sentence,
    description: Faker::Lorem.paragraphs(number: 10).join(' '),
    address_1: Faker::Address.street_address,
    city: Faker::Address.city,
    country_code: "DE",
    longitude: Faker::Address.longitude,
    latitude: Faker::Address.latitude,
    price: Money.from_amount((25..100).to_a.sample)
  )
  property.images.attach(io: File.open(Rails.root.join('db', 'sample_images', "property_#{i + 1}.png")), filename: property.name)

  (1..5).to_a.sample.times do
    Review.create(
      reviewable: property,
      rating: (1..5).to_a.sample,
      title: Faker::Lorem.word,
      body: Faker::Lorem.paragraphs(number: 2).join(' '),
      user: User.all.sample
    )
  end
end
