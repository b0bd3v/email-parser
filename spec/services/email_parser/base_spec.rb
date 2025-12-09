# frozen_string_literal: true

require 'rails_helper'

describe EmailParser::Base do
  let(:mail) do
    double('Mail',
           body: double('Body', decoded: File.read(Rails.root.join('spec', 'fixtures', 'emails', 'email4.eml')),
                                to_s: File.read(Rails.root.join('spec', 'fixtures', 'emails', 'email4.eml'))))
  end

  describe '#value' do
    let(:subclass) do
      Class.new(EmailParser::Base) do
        def customer_name
          value(/Cliente: (.+)/)
        end
      end
    end

    subject { subclass.new(mail) }

    it 'extracts the value using the regex' do
      expect(subject.customer_name).to eq('Ana Costa')
    end
  end
end
