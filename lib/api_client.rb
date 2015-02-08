require 'net/http'

class ApiClient
  def self.response
    begin
      _res = Net::HTTP.get(uri)
    rescue => e
      nil
    end
    _res
  end

  private

  def self.uri
    URI(api_endpoint)
  end

  def self.api_endpoint
    %q[https://api.gojimo.net/api/v4/qualifications]
  end
end
