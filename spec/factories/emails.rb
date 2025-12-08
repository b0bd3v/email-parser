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
    file { fixture_file_upload('upload.eml', 'application/eml') }
  end
end
