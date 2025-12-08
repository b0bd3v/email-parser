# frozen_string_literal: true

module EmailParser
  # Email parser for undefined origins.
  class UndefinedOrigin < Base
    def parse
      GeminiClient.new(prompt).parse
    end

    private

    def prompt
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

        Assunto: #{@mail.subject}

        Email:
        #{@mail.body}
      PROMPT
    end
  end
end
