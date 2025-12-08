# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id            :bigint           not null, primary key
#  email         :string
#  email_subject :string
#  name          :string
#  phone         :string
#  product_code  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Customer < ApplicationRecord
  validates :name, :email_subject, :product_code, presence: true
  validates :email, presence: true, if: -> { phone.blank? }
  validates :phone, presence: true, if: -> { email.blank? }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: -> { email.present? }
  validates :phone, format: { with: /\A\+?[\d\s\-.()]+\z/ }, if: -> { phone.present? }
end
