class Customer < ApplicationRecord
  validates :name, :email_subject, :product_code, presence: true  
  validates :email, presence: true, if: -> { phone.blank? }
  validates :phone, presence: true, if: -> { email.blank? }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: -> { email.present? } 
  validates :phone, format: { with: /\A\+?[\d\s\-\.\(\)]+\z/ }, if: -> { phone.present? }
end
