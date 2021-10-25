FactoryBot.define do
  factory :guest do
    sequence(:email) { |n| "user#{n}@example.com" }
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    phone { [Faker::PhoneNumber.phone_number] }
  end
end
