module VcrToCurl
  class CassetteToCurl
    def initialize(cassette_file)
      @loaded_cassette = YAML.load_file(cassette_file)
    end
  end
end
