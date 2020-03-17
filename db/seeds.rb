# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# 10000.times do
#   Task.create(name: Faker::Name.name,
#               content: Faker::Lorem.paragraph,
#               finish_time: Faker::Date.between(from: 2.days.ago, to: Date.today)
#              )
# end
#
# first user

User.create(user_name: "apa", email: "abc@gmail.com", password: "123456")
