require 'net/http'

class ApiClient
  def response
    begin
      Net::HTTP.start(*opts, &method(:start))
    rescue => e
    end
  end

  private

  def opts
    [uri.host, uri.port, use_ssl: true]
  end

  def start(http)
    http.request(request)
  end

  def request
    req = Net::HTTP::Get.new(uri.request_uri)
    req['If-None-Match'] = %Q[\"#{etag}\"]
    req
  end

  def uri
    URI(api_endpoint)
  end

  def api_endpoint
    Configuration.api_endpoint
  end

  def etag
    data_dir
      .children(false)[0]
      .to_s
      .gsub('.json','') if data_dir.children
  end

  def data_dir
    Pathname(Configuration.data_dir)
  end
end
