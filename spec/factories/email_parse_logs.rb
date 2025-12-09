# frozen_string_literal: true

# == Schema Information
#
# Table name: email_parse_logs
#
#  id            :bigint           not null, primary key
#  error_message :text
#  file_name     :string
#  parsed_data   :jsonb
#  partner_email :string
#  raw_data      :text
#  raw_file_path :string
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  customer_id   :integer
#  email_id      :bigint           not null
#
# Indexes
#
#  index_email_parse_logs_on_email_id  (email_id)
#
# Foreign Keys
#
#  fk_rails_...  (email_id => emails.id)
#
FactoryBot.define do
  factory :email_parse_log do
    status { 'processing' }
    file_name { 'email4.eml' }
    raw_file_path { 'emails/email4.eml' }
    parsed_data { nil }
    raw_data { File.read(Rails.root.join('spec', 'fixtures', 'emails', 'email4.eml')) }
    error_message { nil }
    customer { nil }
    email { create(:email) }

    trait :success do
      status { 'success' }
      parsed_data { { customer_id: 1, product_code: 'ABC123', email_subject: 'Test Email' }.to_json }
      customer { create(:customer) }
    end

    trait :failed do
      status { 'failed' }
      error_message { 'An error occurred' }
      customer { nil }
    end
  end
end
