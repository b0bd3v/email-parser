# frozen_string_literal: true

require 'rails_helper'
require 'support'

describe EmailProcessor do
  let(:processor) { described_class.new('spec/fixtures/emails/email1.eml') }

  it 'processes the file' do
    expected_result = {
      name: 'João da Silva',
      email: 'joao.silva@example.com',
      phone: '(11) 91234-5678',
      product_code: 'ABC123',
      email_subject: 'Pedido de orçamento - Produto ABC123'
    }

    expect(processor.process).to eq(expected_result)
  end
end
