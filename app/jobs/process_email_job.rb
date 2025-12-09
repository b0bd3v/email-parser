# frozen_string_literal: true

# Job to process incoming emails.
class ProcessEmailJob < ApplicationJob
  queue_as :default

  def perform(email_id)
    email = Email.find(email_id)
    EmailProcessor.new(email).process
  end
end
