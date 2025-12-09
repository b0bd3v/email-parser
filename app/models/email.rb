# frozen_string_literal: true

# == Schema Information
#
# Table name: emails
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Email < ApplicationRecord
  has_one_attached :file

  has_many :email_parse_logs

  validates :file, presence: true
  validate :file_extension

  private

  def file_extension
    return unless file.attached? && !file.filename.extension.in?(%w[eml])

    errors.add(:file, 'must be an EML file')
  end
end
