class Configuration
  class << self
    def data_dir
      Pathname.new(dir_name)
        .realpath
        .to_s
    end

    def dir_name
      %q[data]
    end

    def api_endpoint
      %q[https://api.gojimo.net/api/v4/qualifications]
    end
  end
end
