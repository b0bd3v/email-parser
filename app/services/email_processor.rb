class EmailProcessor
  attr_reader :file_content

  def initialize(file_path)
    @file_path = file_path
  end

  def process
    email_parse_log = EmailParseLog.create(
      raw_data: email_from_file.body,
      partner_email: partner_email,
      file_name: File.basename(@file_path),
      raw_file_path: @file_path
    )

    parsed_data = case partner_email
                  when 'loja@fornecedorA.com'
                    EmailParser::PartnerA.new(email_from_file).parse
                  when 'contato@parceiroB.com'
                    EmailParser::PartnerB.new(email_from_file).parse
                  end

    customer = Customer.find_or_create_by!(email: email_from_file.from.first) do |c|
      c.name = parsed_data[:name]
      c.phone = parsed_data[:phone]
      c.email_subject = parsed_data[:email_subject]
      c.product_code = parsed_data[:product_code]
    end

    email_parse_log.parsed_data = parsed_data
    email_parse_log.customer = customer
    email_parse_log.mark_as_success
    email_parse_log.save!

    parsed_data
  rescue
    email_parse_log.mark_as_failed!
    raise
  end

  private

  def file_content
    @file_content ||= File.read(@file_path)
  end

  def email_from_file
    @email_from_file ||= Mail.new(file_content)
  end

  def partner_email
    email_from_file.from.first
  end
end
