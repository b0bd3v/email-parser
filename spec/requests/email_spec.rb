# frozen_string_literal: true

require 'rails_helper'

describe 'Emails', type: :request do
  let(:user) { create(:user) }

  describe 'POST /create' do
    before { sign_in user }

    let(:file_four) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'emails', 'email4.eml'), 'application/eml')
    end
    let(:file_five) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'emails', 'email5.eml'), 'application/eml')
    end

    it 'should return http success' do
      post emails_path, params: { email: { files: [file_four, file_five] } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET /index' do
    before { sign_in user }

    it 'returns http success' do
      get emails_path
      expect(response).to have_http_status(:success)
    end
  end
end
