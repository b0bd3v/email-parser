# frozen_string_literal: true

require 'rails_helper'

describe 'EmailParseLogs', type: :request do
  let(:user) { create(:user) }

  describe 'GET /index' do
    before { sign_in user }

    it 'returns http success' do
      get email_parse_logs_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    let(:email_parse_log) { create(:email_parse_log) }
    before { sign_in user }

    it 'returns http success' do
      get email_parse_log_path(email_parse_log)
      expect(response).to have_http_status(:success)
    end
  end
end
