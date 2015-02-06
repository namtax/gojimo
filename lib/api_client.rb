require 'net/http'
require 'json'

class ApiClient
  attr_reader :response

  CACHE_LENGTH = 1

  def initialize
    persist_data
  end

  def response
    if File.exists?(data_file)
      serialize(File.read(data_file))
    else
      {}
    end
  end

  private

  def serialize(json)
    JSON.parse(json, symbolize_names: true)
  end

  def persist_data
    save_to_disk unless (File.exists?(data_file) && cache_fresh?)
  end

  def save_to_disk
    return unless fetch_from_api
    File.open(data_file, 'w') { |f| f.write fetch_from_api }
  end

  def fetch_from_api
    @response ||= Net::HTTP.get(uri) rescue nil
  end

  def data_file
    File.expand_path('data/response.json')
  end

  def cache_fresh?
    ((Time.now - File.mtime(data_file)) / 3600) < CACHE_LENGTH
  end

  def uri
    URI(api_endpoint)
  end

  def api_endpoint
    %q[https://api.gojimo.net/api/v4/qualifications]
  end
end
