# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id            :bigint           not null, primary key
#  email         :string
#  email_subject :string
#  name          :string
#  phone         :string
#  product_code  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    email_subject { Faker::Lorem.sentence }
    product_code { Faker::Alphanumeric.alphanumeric(number: 7) }

    trait :with_phone_only do
      email { nil }
    end

    trait :with_email_only do
      phone { nil }
    end
  end
end
