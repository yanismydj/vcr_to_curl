require 'vcr'
require 'httparty'
require 'VcrToCurl'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe VcrToCurl::CassetteToCurl do
  # pending "converts a vcr cassette to curl command" do
  #   vcr_to_curl = VcrToCurl::CassetteToCurl.new
  #   vcr_to_curl.curl_command.should eq('curl -X POST -d "fizz=buzz" http://requestb.in/1cn93ai1')
  # end

  describe 'create sample cassette' do
    it 'creates a new cassette' do
      VCR.use_cassette('sample vcr cassette') do
        uri = 'http://requestb.in/1cn93ai1'
        response = HTTParty.post(uri, query: { 'fizz' => 'buzz', 'foo' => 'bar' })
      end
    end
  end
end
