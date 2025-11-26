class AddCustomerIdToEmailParseLog < ActiveRecord::Migration[7.1]
  def change
    add_column :email_parse_logs, :customer_id, :integer
  end
end
