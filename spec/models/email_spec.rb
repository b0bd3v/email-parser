# frozen_string_literal: true

# == Schema Information
#
# Table name: emails
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

describe Email, type: :model do
  it 'validates presence of file' do
    email = build(:email, file: nil)
    expect(email).to_not be_valid
    expect(email.errors[:file]).to include("can't be blank") if email.errors[:file].present?
  end

  it 'should validate file format' do
    email = build(:email, file: fixture_file_upload('upload.eml', 'application/eml'))
    expect(email).to be_valid
  end

  it 'should not validate file format' do
    email = build(:email, file: fixture_file_upload('upload.pdf', 'application/pdf'))
    expect(email).to_not be_valid
    expect(email.errors[:file]).to include('must be an EML file') if email.errors[:file].present?
  end
end
