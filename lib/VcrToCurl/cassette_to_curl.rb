module VcrToCurl
  class CassetteToCurl
    def initialize(cassette_file)
      @loaded_cassette = YAML.load_file(cassette_file)
    end

    def curl_commands
      @curl_commands = []
      http_interactions.each do |http_interaction|
        curl_command = ''
        @curl_commands << curl_command
      end
    end

    def http_interactions
      @loaded_cassette['http_interactions']
    end
  end
end
