require 'rails_helper'

RSpec.describe GeminiClient do
  let(:prompt) { "Extract info from the email" }
  let(:api_key) { "xxxxxx" }
  let(:client) { described_class.new(prompt) }
  let(:api_url) { "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-pro-preview:generateContent" }

  before do
    ENV['GEMINI_API_KEY'] = api_key
  end

  describe '#parse' do
    context 'when API key is missing' do
      before { ENV['GEMINI_API_KEY'] = nil }

      it 'returns an empty hash' do
        expect(client.parse).to eq({})
      end
    end

    context 'when request is successful' do
      let(:response_body) do
        {
          "candidates" => [
            {
              "content" => {
                "parts" => [
                  { "text" => "```json\n{\"name\": \"John Doe\"}\n```" }
                ]
              }
            }
          ]
        }
      end
      let(:faraday_response) { instance_double(Faraday::Response, success?: true, body: response_body) }
      let(:faraday_connection) { instance_double(Faraday::Connection) }

      before do
        allow(Faraday).to receive(:new).and_yield(double('builder').as_null_object).and_return(faraday_connection)
        allow(faraday_connection).to receive(:post).with(GeminiClient::API_URL).and_return(faraday_response)
      end

      it 'parses the JSON response from Gemini' do
        expect(client.parse).to eq({ "name" => "John Doe" })
      end
    end

    context 'when API returns an error' do
      let(:faraday_response) { instance_double(Faraday::Response, success?: false, status: 500, body: "Internal Server Error") }
      let(:faraday_connection) { instance_double(Faraday::Connection) }

      before do
        allow(Faraday).to receive(:new).and_return(faraday_connection)
        allow(faraday_connection).to receive(:post).and_return(faraday_response)
      end

      it 'returns an empty hash and logs error' do
        expect(Rails.logger).to receive(:error).with(/API Request Failed/)
        expect(client.parse).to eq({})
      end
    end

    context 'when JSON parsing fails' do
      let(:response_body) do
        {
          "candidates" => [
            {
              "content" => {
                "parts" => [
                  { "text" => "Invalid JSON" }
                ]
              }
            }
          ]
        }
      end
      let(:faraday_response) { instance_double(Faraday::Response, success?: true, body: response_body) }
      let(:faraday_connection) { instance_double(Faraday::Connection) }

      before do
        allow(Faraday).to receive(:new).and_return(faraday_connection)
        allow(faraday_connection).to receive(:post).and_return(faraday_response)
      end

      it 'returns an empty hash and logs error' do
        expect(Rails.logger).to receive(:error).with(/Failed to parse JSON/)
        expect(client.parse).to eq({})
      end
    end
  end
end
