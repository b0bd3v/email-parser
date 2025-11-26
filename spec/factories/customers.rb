FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }

    trait :with_phone_only do
      email { nil }
    end

    trait :with_email_only do
      phone { nil }
    end
  end
end
