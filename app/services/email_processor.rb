# frozen_string_literal: true

# Processes incoming emails.
class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    @email_parse_log = email_parse_log

    parsed_data.then do |parsed|
      customer = create_customer(parsed)
      update_email_parse_log(parsed, customer)
      parsed
    end
  rescue StandardError
    @email_parse_log&.mark_as_failed!

    raise
  end

  private

  def update_email_parse_log(parsed, customer)
    @email_parse_log.parsed_data = parsed
    @email_parse_log.customer = customer
    @email_parse_log.mark_as_success
    @email_parse_log.save!
  end

  def create_customer(parsed)
    Customer.create_or_find_by!(email: email_from_file.from.first) do |c|
      c.name = parsed[:name]
      c.phone = parsed[:phone]
      c.email_subject = parsed[:email_subject]
      c.product_code = parsed[:product_code]
    end
  end

  def email_parse_log
    @email_parse_log ||= EmailParseLog.create(
      email: @email,
      raw_data: email_from_file.body.decoded.force_encoding('UTF-8'),
      partner_email: partner_email,
      file_name: @email.file.filename.to_s,
      raw_file_path: ActiveStorage::Blob.service.path_for(@email.file.key)
    )
  end

  def parsed_data
    case partner_email
    when 'loja@fornecedorA.com'
      EmailParser::PartnerA.new(email_from_file).parse
    when 'contato@parceiroB.com'
      EmailParser::PartnerB.new(email_from_file).parse
    else
      EmailParser::UndefinedOrigin.new(email_from_file).parse
    end
  end

  def email_from_file
    @email_from_file ||= Mail.new(@email.file.download)
  end

  def partner_email
    email_from_file.from.first
  end
end
