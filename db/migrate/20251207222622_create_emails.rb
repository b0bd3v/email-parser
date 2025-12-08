# frozen_string_literal: true

# Migration to create the Emails table.
class CreateEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :emails, &:timestamps
  end
end
