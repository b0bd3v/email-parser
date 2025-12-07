require 'net/http'
require 'uri'
require 'json'
require 'faraday'

class GeminiClient
  API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-pro-preview:generateContent"

  def initialize(prompt)
    @prompt = prompt
    @api_key = ENV['GEMINI_API_KEY']
  end

  def parse
    return {} if @api_key.nil?

    json_response = request
    parse_response(json_response)
  rescue StandardError => e
    Rails.logger.error("GeminiClient Error: #{e.message}")
    {}
  end

  private

  def request
    conn = Faraday.new do |f|
      f.request :json
      f.response :json, content_type: /\bjson$/
      f.adapter Faraday.default_adapter
    end

    response = conn.post(API_URL) do |req|
      req.headers['Content-Type']  = 'application/json'
      req.headers['x-goog-api-key'] = ENV.fetch('GEMINI_API_KEY')
      req.body = { contents: [{ parts: [{ text: @prompt }] }] }
    end

    unless response.success?
      raise "API Request Failed: #{response.status} #{response.body}" 
    end

    response.body
  end

  def parse_response(json)
    content = json.dig('candidates', 0, 'content', 'parts', 0, 'text')
    return {} unless content

    clean_content = content.gsub(/```json\n?|\n?```/, '').strip
    JSON.parse(clean_content)
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse JSON from Gemini response: #{e.message}")
    {}
  end
end
