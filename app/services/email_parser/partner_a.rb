module EmailParser
  class PartnerA < Base
    def parse
      {
        name: value(/(?:Nome|Nome do cliente): (.+)/),
        email: value(/E-mail: (.+)/),
        phone: value(/Telefone: (.+)/),
        product_code: value(/\bproduto(?:\s+de\s+c[óo]digo)?\s+([A-Z]{3}\d{3})\b/),
        email_subject: mail.subject
      }
    end
  end
end
