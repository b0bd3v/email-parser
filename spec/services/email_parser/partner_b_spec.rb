# frozen_string_literal: true

require 'rails_helper'
require 'support'

describe EmailParser::PartnerB do
  email_files('contato@parceiroB.com').each do |file_path|
    filename = File.basename(file_path)
    file_content = File.read(file_path)

    context "when parsing #{filename}" do
      let(:mail) { double_mail(file_content) }

      subject { described_class.new(mail) }

      it 'returns the parsed data' do
        expected_data = case filename
                        when 'email4.eml'
                          {
                            name: 'Ana Costa',
                            email: 'ana.costa@example.com',
                            phone: '+55 31 97777-1111',
                            product_code: 'PROD-555',
                            email_subject: 'Cliente interessado no PROD-555'
                          }
                        when 'email5.eml'
                          {
                            name: 'Ricardo Almeida',
                            email: 'ricardo.almeida@example.com',
                            phone: '41 98888-2222',
                            product_code: 'PROD-888',
                            email_subject: 'Solicitação recebida - PROD-888'
                          }
                        when 'email6.eml'
                          {
                            name: 'Fernanda Lima',
                            email: nil,
                            phone: '61 93333-4444',
                            product_code: 'PROD-999',
                            email_subject: 'Pedido de informações - PROD-999'
                          }
                        when 'email8.eml'
                          {
                            name: 'Fernanda Lima',
                            email: nil,
                            phone: nil,
                            product_code: 'PROD-999',
                            email_subject: 'Pedido de informações - PROD-999'
                          }
                        else
                          {}
                        end

        expect(subject.parse).to include(expected_data)
      end
    end
  end
end
