require 'net/http'
require 'json'

class ApiClient
  attr_reader :response

  def initialize
    @response = serialize(Net::HTTP.get(uri))
  end

  private

  def serialize(json)
    JSON.parse(json, symbolize_names: true)
  end

  def uri
    URI(api_endpoint)
  end

  def api_endpoint
    %q[https://api.gojimo.net/api/v4/qualifications]
  end
end
