# frozen_string_literal: true

# Migration to add partner_email to the EmailParseLog table.
class AddPartnerEmailToEmailParseLog < ActiveRecord::Migration[7.1]
  def change
    add_column :email_parse_logs, :partner_email, :string
  end
end
