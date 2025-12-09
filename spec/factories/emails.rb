# frozen_string_literal: true

# == Schema Information
#
# Table name: emails
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :email do
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'upload.eml'), 'application/eml') }
  end
end
