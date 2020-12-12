require 'net/http'
require 'json'

class RjcActionNetwork::ActionNetworkClient
  def initialize
    @api_key = ENV.fetch('RJC_API_KEY')
    @api_url = ENV.fetch('RJC_API_URL')
  end

  def build_paginated_requests(endpoint)
    page = 1
    data = []

    loop do
      results = request(endpoint, page)
      data = data.concat([results]).flatten.uniq
      return data if results.nil? || results.empty?

      page += 1
    end
  end

  private

  def request(endpoint, page=1)
    uri = URI("#{api_url}/#{endpoint}?page=#{page}")
    req = Net::HTTP::Get.new(uri)
    req['x-api-key'] = api_key

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      response = http.request req
      name = endpoint.split('/').last
      resp = JSON.parse(response.body).dig("_embedded", "osdi:#{name}")
      resp
    end
  end

  attr_reader :api_key, :api_url
end
