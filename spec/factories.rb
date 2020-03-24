require "faker"
FactoryBot.define do
  factory :user do
    user_name { "apa" }
    email { "123@gmail.com" }
    password_digest { "123456" }
  end

  factory :task do
    name { Faker::Name.name }
    content  { Faker::Lorem.paragraph }
    finish_time { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    priority { 0 }
    user
  end
end
