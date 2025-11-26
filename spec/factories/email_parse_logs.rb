FactoryBot.define do
  factory :email_parse_log do
    status { :processing }
    file_name { 'email4.eml' }
    raw_file_path { 'emails/email4.eml' }
    parsed_data { nil }
    raw_data { File.read(Rails.root.join('spec', 'emails', 'email4.eml')) }
    error_message { nil }
    customer { nil }

    trait :success do
      status { :success }
      parsed_data { { customer_id: 1, product_code: 'ABC123', email_subject: 'Test Email' }.to_json }
      customer { build(:customer) }
    end

    trait :failed do
      status { :failed }
      error_message { 'An error occurred' }
      customer { nil }
    end
  end
end
