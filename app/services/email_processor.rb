class EmailProcessor
  attr_reader :file_content

  def initialize(file_path)
    @file_path = file_path
  end

  def process
    EmailParseLog.create(
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

    parsed_data
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
