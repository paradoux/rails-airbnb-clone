# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "cleaning database"

User.destroy_all
Article.destroy_all

puts "setting variables"
b = ["kg", "piece", "g", "l"]
c = ["kjebdakzjehd_tmh4wi.jpg", "vietnam_hanoi_012_chien_roti_au_menu_tqzfoe.jpg","sample.jpg"]


puts "starting user creation"

User.create!(email:"test@lepicerie.com" ,
                    address: "#{Faker::Address.street_address} #{Faker::Address.zip_code} #{Faker::Address.city}",
                    first_name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name,
                    bio:Faker::Lorem.sentence(4, true, 8),
                    password: "password")
puts  "#{User.count} users created"

puts "starting Articles creation"

users = User.all
10.times do
  a = Article.create!(name: Faker::Food.ingredient, unit: b.sample,
                    description: Faker::Lorem.sentence(4, true, 10),
                    image: c.sample, delivery_date: Date.new(2017, rand(8..10), rand(1..30)),
                    price: rand(1..30), quantity: rand(1..30), active: [:inactif, :actif].sample,
                    user: users.sample)
end

puts  "#{Article.count} articles created"
