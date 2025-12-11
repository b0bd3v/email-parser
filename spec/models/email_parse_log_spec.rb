# frozen_string_literal: true

# == Schema Information
#
# Table name: email_parse_logs
#
#  id            :bigint           not null, primary key
#  error_message :text
#  file_name     :string
#  parse_method  :string
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
require 'rails_helper'

describe EmailParseLog do
  let(:log) { build(:email_parse_log) }
  let(:customer) { create(:customer) }
  let(:parsed_data) do
    { product_code: Faker::Alphanumeric.alphanumeric(number: 6),
      email_subject: Faker::Lorem.sentence,
      customer_name: Faker::Name.name,
      customer_email: Faker::Internet.email }
  end

  describe 'validations' do
    context 'customer' do
      it 'is valid' do
        log.mark_as_success
        log.customer = create(:customer)
        log.parsed_data = parsed_data
        log.save!

        expect(log).to be_valid
        expect(log.customer).to be_present
        expect(log.success?).to be true
        expect(log.errors[:customer]).to be_empty
      end

      it 'is invalid when status is processing and customer is present' do
        log.customer = build(:customer)
        expect(log).to be_invalid
        expect(log.errors[:customer]).to include('must be blank when status is processing')
      end

      it 'is invalid when status is failed and customer is present' do
        log.customer = build(:customer)
        log.mark_as_failed
        expect(log).to be_invalid
        expect(log.errors[:customer]).to include('must be blank when status is failed')
      end
    end

    context 'parsed_data' do
      it 'is valid' do
        log.mark_as_success
        log.parsed_data = parsed_data
        log.customer = create(:customer)
        log.save!

        expect(log).to be_valid
        expect(log.parsed_data).to be_present
        expect(log.success?).to be true
        expect(log.errors[:parsed_data]).to be_empty
      end

      it 'is invalid when status is processing and parsed_data is present' do
        log.parsed_data = parsed_data

        expect(log).to be_invalid
        expect(log.errors[:parsed_data]).to include('must be blank when status is processing')
      end

      it 'is invalid when status is failed and parsed_data is present' do
        log.parsed_data = parsed_data
        log.mark_as_failed

        expect(log).to be_invalid
        expect(log.errors[:parsed_data]).to include('must be blank when status is failed')
      end
    end

    context 'error_message' do
      it 'is valid' do
        log.mark_as_failed
        log.error_message = 'An error occurred'
        log.save!

        expect(log).to be_valid
        expect(log.error_message).to be_present
        expect(log.failed?).to be true
        expect(log.errors[:error_message]).to be_empty
      end

      it 'is invalid when status is processing and error_message is present' do
        log.error_message = 'An error occurred'
        expect(log).to be_invalid
        expect(log.errors[:error_message]).to include('must be blank when status is processing')
      end

      it 'is invalid when status is success and error_message is present' do
        log.error_message = 'An error occurred'
        log.mark_as_success
        expect(log).to be_invalid
        expect(log.errors[:error_message]).to include('must be blank when status is success')
      end
    end

    context 'customer' do
      it 'is valid' do
        log.mark_as_success
        log.customer = create(:customer)
        log.parsed_data = parsed_data
        log.save!

        expect(log).to be_valid
        expect(log.customer).to be_present
        expect(log.success?).to be true
        expect(log.errors[:customer]).to be_empty
      end

      it 'is invalid when status is processing and customer is present' do
        log.customer = build(:customer)
        expect(log).to be_invalid
        expect(log.errors[:customer]).to include('must be blank when status is processing')
      end

      it 'is invalid when status is failed and customer is present' do
        log.customer = build(:customer)
        log.mark_as_failed
        expect(log).to be_invalid
        expect(log.errors[:customer]).to include('must be blank when status is failed')
      end
    end

    context 'file_name' do
      it 'is valid' do
        log.file_name = 'email1.eml'
        log.save!

        expect(log).to be_valid
        expect(log.file_name).to be_present
        expect(log.errors[:file_name]).to be_empty
      end

      it 'is invalid when file_name is blank' do
        log.file_name = nil
        expect(log).to be_invalid
        expect(log.errors[:file_name]).to include("can't be blank")
      end
    end

    context 'raw_file_path' do
      it 'is valid' do
        log.raw_file_path = 'emails/email1.eml'
        log.save!

        expect(log).to be_valid
        expect(log.raw_file_path).to be_present
        expect(log.errors[:raw_file_path]).to be_empty
      end

      it 'is invalid when raw_file_path is blank' do
        log.raw_file_path = nil
        expect(log).to be_invalid
        expect(log.errors[:raw_file_path]).to include("can't be blank")
      end
    end
  end
end
