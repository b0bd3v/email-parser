require 'rails_helper'

RSpec.describe ProcessEmailJob, type: :job do
  before { ActiveJob::Base.queue_adapter = :test }

  describe '#perform_later' do
    it 'enqueues the job' do
      expect { described_class.perform_later(1) }.to have_enqueued_job(described_class).with(1)
    end

    it 'enqueues the job on the default queue' do
      expect { described_class.perform_later(1) }.to have_enqueued_job(described_class).on_queue(:default)
    end
  end

  describe '#perform_now' do
    let(:file_path) { Rails.root.join('spec/fixtures/emails/email4.eml').to_s }
    it 'creates an EmailParseLog with success status' do
      described_class.perform_now(file_path)
      
      expect(EmailParseLog.last.status).to eq('success')
    end
  end
end
