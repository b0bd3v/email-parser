# frozen_string_literal: true

# == Schema Information
#
# Table name: email_parse_logs
#
#  id            :bigint           not null, primary key
#  error_message :text
#  file_name     :string
#  parsed_data   :jsonb
#  partner_email :string
#  raw_data      :text
#  raw_file_path :string
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  customer_id   :integer
#
class EmailParseLog < ApplicationRecord
  include AASM

  belongs_to :customer, optional: true

  ABSENCE_MESSAGE = ->(object, _data) { "must be blank when status is #{object.status}" }

  validates :file_name, presence: true
  validates :raw_file_path, presence: true

  with_options if: :processing? do
    validates :parsed_data, :customer, :error_message, absence: { message: ABSENCE_MESSAGE }
  end

  with_options if: :success? do
    validates :parsed_data, :customer, presence: true
    validates :error_message, absence: { message: ABSENCE_MESSAGE }
  end

  with_options if: :failed? do
    validates :error_message, presence: true
    validates :parsed_data, :customer, absence: { message: ABSENCE_MESSAGE }
  end

  aasm column: :status do
    state :processing, initial: true
    state :success
    state :failed

    event :mark_as_success do
      transitions from: :processing, to: :success
    end

    event :mark_as_failed do
      transitions from: :processing, to: :failed
    end
  end
end
