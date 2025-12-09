# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customers', type: :request do
  let(:user) { create(:user) }

  describe 'GET /index' do
    before { sign_in user }

    it 'returns http success' do
      get customers_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    let(:customer) { create(:customer) }

    before { sign_in user }

    it 'returns http success' do
      get customer_path(customer)
      expect(response).to have_http_status(:success)
    end
  end
end
