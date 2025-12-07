require 'rails_helper'
require 'support'

describe EmailParser::UndefinedOrigin do
  let(:expected_email_9) {
    {
      "name" => "Fernando Luiz da Silva",
      "email" => "contato@example.com",
      "phone" => "51995921850",
      "product_code" => "FTF-123",
      "email_subject" => "Pedido de informações sobre quipamento"
    }
  }

  let(:expected_email_10) {
    {
      "name" => "Fernando Luiz da Silva",
      "email" => "contato@example.com",
      "phone" => "51996027850",
      "product_code" => "PROD-999",
      "email_subject" => "Cliente interessado no PROD-999"
    }
  }

  email_files('roberto.martins.info@gmail.com').each do |file_path|
    filename = File.basename(file_path)
    file_content = File.read(file_path)

    context "when parsing #{filename}" do
      let(:expected_data) { case filename when 'email9.eml' then expected_email_9 when 'email10.eml' then expected_email_10 end }
      let(:mail) { Mail.new(file_content) }
      let(:prompt) do
        <<~PROMPT
        Você é um assistente de atendimento ao cliente que precisa extrair as informações de um email.

        Extraia as seguintes informações:
        - Nome (se houver)
        - Email (se houver)
        - Telefone (se houver)
        - Codigo do produto (se houver)
        - Assunto

        Formate a resposta como um JSON. Retorne apenas o JSON, sem nenhum texto adicional.
          {
            "name": "Nome do cliente",
            "email": "Email do cliente",
            "phone": "Telefone do cliente",
            "product_code": "Codigo do produto",
            "email_subject": "Assunto do email"
          }

        Assunto: #{mail.subject}

        Email:
        #{mail.body}
      PROMPT
      end

      subject { EmailParser::UndefinedOrigin.new(mail) }

      before do
        allow(GeminiClient).to receive(:new).with(prompt).and_return(instance_double(GeminiClient, parse: expected_data))
      end

      it 'returns the parsed data' do
        expect(subject.parse).to eq(expected_data)
      end
    end
  end
end
