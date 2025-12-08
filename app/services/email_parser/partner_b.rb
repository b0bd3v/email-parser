# frozen_string_literal: true

module EmailParser
  # Email parser for Partner B.
  class PartnerB < Base
    def parse
      {
        name: value(/(?:Cliente|Nome completo|Nome do cliente): (.+)/),
        email: value(/(?:Email|E-mail de contato|E-mail): (.+)/),
        phone: value(/Telefone: (.+)/),
        product_code: value(/(?:Produto de interesse|Código do produto|Produto): (.+)/),
        email_subject: mail.subject
      }
    end
  end
end
