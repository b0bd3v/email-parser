# frozen_string_literal: true

# Migration to create the EmailParseLogs table.
class CreateEmailParseLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :email_parse_logs do |t|
      t.string :status
      t.string :file_name
      t.string :raw_file_path
      t.jsonb :parsed_data
      t.text :raw_data
      t.text :error_message

      t.timestamps
    end
  end
end
