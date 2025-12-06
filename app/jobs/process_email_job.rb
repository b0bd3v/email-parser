class ProcessEmailJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    EmailProcessor.new(file_path).process
  end
end
