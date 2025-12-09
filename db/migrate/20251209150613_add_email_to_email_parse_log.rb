# frozen_string_literal: true

class AddEmailToEmailParseLog < ActiveRecord::Migration[7.1]
  def change
    add_reference :email_parse_logs, :email, null: false, foreign_key: true
  end
end
