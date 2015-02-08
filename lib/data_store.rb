require 'json'

class DataStore
  attr_reader :response

  CACHE_LENGTH = 1

  def initialize
    store
  end

  def all
    serialize(raw_json)
  end

  def store
    fetch_from_api && write unless data_healthy?
  end

  private

  def serialize(json)
    JSON.parse(json, symbolize_names: true)
  end

  def raw_json
    File.read(data_file)
  end

  def data_file
    File.expand_path('data/response.json')
  end

  def fetch_from_api
    @response ||= ApiClient.response
  end

  def write
    open(data_file, 'w') { |f| f.write response } if response
  end

  def data_healthy?
    File.exists?(data_file) && cache_fresh?
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
