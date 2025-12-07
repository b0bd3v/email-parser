require 'rails_helper'

describe "Emails", type: :request do
  describe "POST /create" do
    let(:file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'emails', 'email4.eml'), 'application/eml') }

    it "should return http success" do
      post emails_path, params: { email: { file: file } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get emails_path
      expect(response).to have_http_status(:success)
    end
  end
end
