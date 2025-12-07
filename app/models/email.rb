class Email < ApplicationRecord
  has_one_attached :file

  validates :file, presence: true
  validate :file_extension

  private

  def file_extension
    if file.attached? && !file.filename.extension.in?(%w(eml))
      errors.add(:file, "must be an EML file")
    end
  end
end
