require 'vcr'
require 'httparty'
require 'webmock'
require 'pry'
require 'VcrToCurl'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe VcrToCurl::CassetteToCurl do
  describe '#curl_commands' do
    describe 'request with body and no headers' do
      let(:cassette) { 'fixtures/vcr_cassettes/sample_vcr_cassette.yml' }
      let(:vcr_to_curl) { VcrToCurl::CassetteToCurl.new(cassette) }

      it 'has the correct_number of commands based on the interactions' do
        expect(vcr_to_curl.curl_commands.length).to eq(1)
      end

      it "converts the interaction to curl command" do
        curl_command = vcr_to_curl.curl_commands[0]
        expect(curl_command).to eq("curl -X POST -d 'fizz=buzz&foo=bar' 'http://echo.httpkit.com/'")
      end

      describe '#http_interactions' do
        it 'has the correct number of interactions' do
          expect(vcr_to_curl.http_interactions.length).to eq(1)
        end
      end
    end

    describe 'request with headers and no body' do
      let(:cassette) { 'fixtures/vcr_cassettes/sample_vcr_cassette_with_headers.yml' }
      let(:vcr_to_curl) { VcrToCurl::CassetteToCurl.new(cassette) }

      it 'creates the correct curl command' do
        curl_command = vcr_to_curl.curl_commands[0]
        expect(curl_command).to eq("curl -X POST -H 'Yan: isawesome' 'http://echo.httpkit.com/'")
      end
    end

    describe 'request with headers and body' do
      let(:cassette) { 'fixtures/vcr_cassettes/sample_vcr_cassette_with_headers_and_post_data.yml' }
      let(:vcr_to_curl) { VcrToCurl::CassetteToCurl.new(cassette) }

      it 'creates the correct curl command' do
       curl_command = vcr_to_curl.curl_commands[0]
       expect(curl_command).to eq("curl -X POST -d 'foo=blah' -H 'Yan: isawesome' 'http://echo.httpkit.com/'")
      end
    end

    describe 'request with query' do
      let(:cassette) { 'fixtures/vcr_cassettes/sample_vcr_cassette_with_query.yml' }
      let(:vcr_to_curl) { VcrToCurl::CassetteToCurl.new(cassette) }

      it 'creates the correct curl command' do
       curl_command = vcr_to_curl.curl_commands[0]
       expect(curl_command).to eq("curl -X GET -H 'Accept-encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3' -H 'Accept: */*' -H 'User-agent: Ruby' 'https://www.google.com/?give_a_bit=to_me'")
      end
    end
  end

  # methods to create cassettes only
  describe 'create sample cassettes' do
    xit 'creates a new cassette' do
      VCR.use_cassette('sample vcr cassette') do
        uri = 'http://echo.httpkit.com'
        response = HTTParty.post(uri, body: { 'fizz' => 'buzz', 'foo' => 'bar' })
      end
    end

    xit 'creates a cassette with headers' do
      VCR.use_cassette('sample vcr cassette with headers') do
        uri = 'http://echo.httpkit.com'
        response = HTTParty.post(uri, headers: { 'Yan' => 'isawesome' })
      end
    end

    xit 'creates a cassette with headers and post data' do
      VCR.use_cassette('sample vcr cassette with headers and post data') do
        uri = 'http://echo.httpkit.com'
        response = HTTParty.post(uri, headers: { 'Yan' => 'isawesome' }, body: { foo: "blah"})
      end
    end

    xit 'creates a cassette with headers, params and post data' do
      VCR.use_cassette('sample vcr cassette with query') do
        uri = 'https://www.google.com' # service echo.httpkit.com does not work
        response = HTTParty.get(uri, query: { give_a_bit: :to_me })
      end
    end
  end
end
