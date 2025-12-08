# frozen_string_literal: true

# Job to process incoming emails.
class ProcessEmailJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    EmailProcessor.new(file_path).process
  end
end
