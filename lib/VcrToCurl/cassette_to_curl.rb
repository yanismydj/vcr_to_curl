require 'yaml'

module VcrToCurl
  class CassetteToCurl
    def initialize(cassette_file)
      @loaded_cassette = ::YAML.load_file(cassette_file)
    end

    def curl_commands
      http_interactions.map do |http_interaction|
        convert_request_to_curl(http_interaction["request"])
      end
    end

    def convert_request_to_curl(request)
      curl_command = "curl -X #{request_type(request)} "
      curl_command += request_data(request) if has_data?(request)
      curl_command += request_headers(request) if has_headers?(request)
      curl_command += request_url(request)
      curl_command
    end

    def http_interactions
      @loaded_cassette['http_interactions']
    end

    private
      def has_data?(request)
        request["body"]["string"].length > 0
      end

      def has_headers?(request)
        request["headers"].keys.size > 0
      end

      def request_type(request)
        request["method"].upcase
      end

      def request_url(request)
        request["uri"]
      end

      def request_data(request)
        "-d '#{request["body"]["string"]}' "
      end

      def request_headers(request)
        header_string = ''
        request["headers"].each do |key, value|
          header_string += "-H '#{key.capitalize}: #{value[0]}' "
        end
        header_string
      end
  end
end
