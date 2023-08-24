require "open-uri"
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


me = User.create!(email: 'peteco@gmail.com', password: '123456')

me.profile.update(first_name: 'Pet', last_name: 'Eco', country_code: "DE")

# image_path = Rails.root.join('db', 'sample_images', "user_6.jpg")
# me.profile.picture.attach(io: File.open(image_path), filename: "#{me.full_name}.jpg")

#  'CLOUDINARY_URL'
cloudinary_url = 'https://res.cloudinary.com/dnmf6p8tj/image/upload/v1692828739/airbnb-clone/user_6.jpg'

# Attach the Cloudinary URL as the profile picture
me.profile.picture.attach(io: URI.parse(cloudinary_url).open, filename: "#{me.full_name}.jpg")
me.profile.save!

# Create users using Faker data
5.times do |i|

  email = Faker::Internet.email
  password = '123456' # Set a default password for all users
  user = User.create!( email: email, password: '123456')
  user.profile.update(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)

  # # Attach a profile picture to each user
  # image_path = Rails.root.join('db', 'sample_images', "user_#{i + 1}.jpg")
  # user.profile.picture.attach(io: File.open(image_path), filename: "#{user.full_name}.jpg")

  # 'CLOUDINARY_URL'
  cloudinary_url = "https://res.cloudinary.com/dnmf6p8tj/image/upload/v1692828739/airbnb-clone/user_#{i + 1}.jpg"

  # Attach the Cloudinary URL as the profile picture
  user.profile.picture.attach(io: URI.parse(cloudinary_url).open, filename: "#{user.full_name}.jpg")
  user.profile.save!

end

8.times do |i|
  property = Property.create!(
    user: me,
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

  main_image_url = "https://res.cloudinary.com/dnmf6p8tj/image/upload/v1692828738/airbnb-clone/property_#{property.id}_main_image.jpg"

  begin
    main_image_io = URI.open(main_image_url)
    property.main_image.attach(io: main_image_io, filename: "property_#{property.id}_main_image.jpg")
  rescue OpenURI::HTTPError => e
    puts "Error attaching main image: #{e.message}"
  end

  4.times do |j|
    secondary_image_number = j + 1
    secondary_image_url = "https://res.cloudinary.com/dnmf6p8tj/image/upload/v1692899529/airbnb-clone/property_#{property.id}_secondary_#{secondary_image_number}.jpg"

    begin
      secondary_image_io = URI.open(secondary_image_url)
      property.secondary_images.attach(io: secondary_image_io, filename: "property_#{property.id}_secondary_#{secondary_image_number}.jpg")
    rescue OpenURI::HTTPError => e
      puts "Error attaching secondary image #{secondary_image_number}: #{e.message}"
    end
  end

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
