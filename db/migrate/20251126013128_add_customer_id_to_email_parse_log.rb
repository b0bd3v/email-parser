# frozen_string_literal: true

# Migration to add customer_id to the EmailParseLog table.
class AddCustomerIdToEmailParseLog < ActiveRecord::Migration[7.1]
  def change
    add_column :email_parse_logs, :customer_id, :integer
  end
end
