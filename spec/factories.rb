require "faker"
FactoryBot.define do
  factory :user do
    user_name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
  end

  factory :task do
    name { Faker::Name.name }
    content  { Faker::Lorem.paragraph }
    finish_time { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    priority { 0 }
  end
end
