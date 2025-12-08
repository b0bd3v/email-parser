# frozen_string_literal: true

# Migration to add product_code and email_subject columns to the Customers table.
class AddProductCodeAndEmailSubjectToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :product_code, :string
    add_column :customers, :email_subject, :string
  end
end
