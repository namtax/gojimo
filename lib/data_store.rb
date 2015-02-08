require 'json'

class DataStore
  attr_reader :client, :response

  def initialize(client = ApiClient.new)
    @client = client
    store
  end

  def fetch
    serialize(raw_json)
  end

  def store
    (clear && write) if (valid_response? && empty?)
  end

  private

  def serialize(json)
    JSON.parse(json, symbolize_names: true)
  end

  def raw_json
    File.read(data_file)
  end

  def data_file
    "#{data_dir}/#{etag}.json"
  end

  def data_dir
    Configuration.data_dir
  end

  def etag
    response['etag'].gsub(/\"/,'')
  end

  def clear
    Dir["#{data_dir}/*"].each do |f|
      FileUtils.rm_f(f)
    end
  end

  def write
    open(data_file, 'w') do |f|
      f.write response.body
    end
  end

  def valid_response?
    (response && response.code["200"])
  end

  def response
    @response ||= client.response
  end

  def empty?
    !File.exists?(data_file)
  end
end
