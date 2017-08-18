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
Order.destroy_all

puts "setting variables"
b = ["kg", "piece", "g", "l"]
c = ["kjebdakzjehd_tmh4wi.jpg", "vietnam_hanoi_012_chien_roti_au_menu_tqzfoe.jpg","sample.jpg"]


puts "starting user creation"

# buyer profile

User.create!(email:"buyer@lepicerie.com" ,
                    address: "#{Faker::Address.street_address} #{Faker::Address.zip_code} #{Faker::Address.city}",
                    first_name: "Bob",
                    last_name: "Achete",
                    bio:Faker::Lorem.sentence(4, true, 8),
                    password: "password")
# Vendor profile

User.create!(email:"vendor@lepicerie.com" ,
                    address: "#{Faker::Address.street_address} #{Faker::Address.zip_code} #{Faker::Address.city}",
                    first_name: "Cindy",
                    last_name: "Vendu",
                    bio:Faker::Lorem.sentence(4, true, 8),
                    password: "password")
# Other profiles

3.times do
User.create!(email: Faker::Internet.email ,
                    address: "#{Faker::Address.street_address} #{Faker::Address.zip_code} #{Faker::Address.city}",
                    first_name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name,
                    bio:Faker::Lorem.sentence(4, true, 8),
                    password: "password")
end

puts  "#{User.count} users created"

puts "starting Articles creation"

vendor = User.find_by_email('vendor@lepicerie.com')

# un article inactif pour le vendeur

inactive_article = Article.create!(name: Faker::Food.ingredient, unit: b.sample,
                description: Faker::Lorem.sentence(4, true, 10),
                image: c.sample, delivery_date: Date.new(2017, rand(8..10), rand(1..30)),
                price: rand(1..30), quantity: rand(1..30), active: :inactif,
                user: vendor)

# des articles actifs pour chaque status

active_articles = []
Order.statuses.length.times do
  active_articles << Article.create!(name: Faker::Food.ingredient, unit: b.sample,
                description: Faker::Lorem.sentence(4, true, 10),
                image: c.sample,
                delivery_date: Date.new(2017, rand(8..10), rand(1..30)),
                price: rand(1..30), quantity: rand(1..30),
                active: :actif,
                user: vendor)
end


# Random articles

users = User.all

10.times do
  Article.create!(name: Faker::Food.ingredient, unit: b.sample,
                  description: Faker::Lorem.sentence(4, true, 10),
                  image: c.sample,
                  delivery_date: Date.new(2017, rand(8..10), rand(1..30)),
                  price: rand(1..30), quantity: rand(1..30),
                  active: [:inactif, :actif].sample,
                  user: users.sample)
end

puts  "#{Article.count} articles created"

# Une order par status

puts "Starting orders creation"

buyer = User.find_by_email('buyer@lepicerie.com')
i = 0
Order.statuses.each do |status, _value|
  Order.create!(status: status,
                comment: Faker::Lorem.sentence(4, true),
                user: buyer,
                article: active_articles[i])
  i += 1
end

puts  "#{Order.count} orders created"


