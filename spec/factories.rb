require "faker"
FactoryBot.define do
  factory :tagging do
    tag { nil }
    post { nil }
  end

  factory :tag do
    name { "MyString" }
  end

  factory :role do
  end

  factory :user do
    user_name { "apa" }
    email { "123@gmail.com" }
    password { "123456" }
  end

  factory :task do
    name { Faker::Name.name }
    content  { Faker::Lorem.paragraph }
    finish_time { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    priority { 0 }
    user
  end
end
