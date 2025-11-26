require 'rails_helper'

describe EmailParser::PartnerA do
  files = Dir[Rails.root.join('spec', 'emails', '*.eml')].select do |file|
    File.read(file).include?('loja@fornecedorA.com')
  end.sort

  files.each do |file_path|
    filename = File.basename(file_path)
    file_content = File.read(file_path)

    context "when parsing #{filename}" do
      let(:mail) do
        double('Mail',
          body: double('Body', to_s: file_content),
          subject: file_content.match(/Subject: (.+)/)[1].strip,
        )
      end

      subject { described_class.new(mail) }

      it 'returns the parsed data' do
        expected_data = case filename
                        when 'email1.eml'
                          {
                            name: 'João da Silva',
                            email: 'joao.silva@example.com',
                            phone: '(11) 91234-5678',
                            product_code: 'ABC123',
                            email_subject: 'Pedido de orçamento - Produto ABC123'
                          }
                        when 'email2.eml'
                          {
                            name: 'Maria Oliveira',
                            email: 'maria.oliveira@example.com',
                            phone: '21 99876-5432',
                            product_code: 'XYZ987',
                            email_subject: 'Interesse no produto XYZ987'
                          }
                        when 'email3.eml'
                          {
                            name: 'Pedro Santos',
                            email: 'pedro.santos@example.com',
                            phone: nil,
                            product_code: 'LMN456',
                            email_subject: 'Solicitação de cotação - Produto LMN456'
                          }
                        when 'email7.eml'
                          {
                            name: 'Pedro Santos',
                            email: nil,
                            phone: nil,
                            product_code: 'LMN456',
                            email_subject: 'Solicitação de cotação - Produto LMN456'
                          }
                        else
                          {}
                        end

        expect(subject.parse).to include(expected_data)
      end
    end
  end
end