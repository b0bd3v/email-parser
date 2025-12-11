class AddParseMethodToEmailParseLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :email_parse_logs, :parse_method, :string
  end
end
