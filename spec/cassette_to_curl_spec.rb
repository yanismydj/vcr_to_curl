require 'net/http'
require 'vcr'
require 'VcrToCurl'

describe VcrToCurl::CassetteToCurl do
  pending "converts a vcr cassette to curl command" do
    vcr_to_curl = VcrToCurl::CassetteToCurl.new
    vcr_to_curl.curl_command.should eq('curl -X POST -d "fizz=buzz" http://requestb.in/1cn93ai1')
  end

  describe 'create sample cassette' do
    it 'creates a new cassette' do
      VCR.use_cassette('sample vcr cassette', record: :new) do
        uri = URI('http://requestb.in/1cn93ai1')
        res = Net::HTTP.post_form(uri, 'fizz' => 'buzz', 'foo' => 'bar')
        puts res.body
      end
    end
  end
end
