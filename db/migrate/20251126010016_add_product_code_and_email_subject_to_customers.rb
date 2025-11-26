class AddProductCodeAndEmailSubjectToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :product_code, :string
    add_column :customers, :email_subject, :string
  end
end
