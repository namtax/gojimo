require 'net/http'

class ApiClient
  def self.response
    begin
      Net::HTTP.start(*opts, &method(:start))
    rescue => e
    end
  end

  private

  def self.opts
    [uri.host, uri.port, use_ssl: true]
  end

  def self.start(http)
    http.request(request).body
  end

  def self.request
    Net::HTTP::Get.new(uri.path)
  end

  def self.uri
    URI(api_endpoint)
  end

  def self.api_endpoint
    %q[https://api.gojimo.net/api/v4/qualifications]
  end
end
