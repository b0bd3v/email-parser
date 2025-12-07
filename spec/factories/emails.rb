FactoryBot.define do
  factory :email do
    file { fixture_file_upload('upload.eml', 'application/eml') }
  end
end
