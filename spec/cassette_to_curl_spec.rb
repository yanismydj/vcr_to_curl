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
  let(:cassette) { 'fixtures/vcr_cassettes/sample_vcr_cassette.yml' }
  let(:vcr_to_curl) { VcrToCurl::CassetteToCurl.new(cassette) }

  describe '#curl_commands' do
    describe 'request with body and no headers' do
      it 'has the correct_number of commands based on the interactions' do
        expect(vcr_to_curl.curl_commands.length).to eq(1)
      end

      it "converts the interaction to curl command" do
        curl_command = vcr_to_curl.curl_commands[0]
        expect(curl_command).to eq("curl -X POST -d 'fizz=buzz&foo=bar' http://requestb.in/1cn93ai1")
      end
    end

    describe 'request with headers and no body' do
      it 'creates the correct curl command' do

      end
    end
  end

  describe '#http_interactions' do
    it 'has the correct number of interactions' do
      expect(vcr_to_curl.http_interactions.length).to eq(1)
    end
  end

  describe 'create sample cassettes' do
    it 'creates a new cassette' do
      VCR.use_cassette('sample vcr cassette') do
        uri = 'http://requestb.in/1cn93ai1'
        response = HTTParty.post(uri, body: { 'fizz' => 'buzz', 'foo' => 'bar' })
      end
    end

    it 'creates a cassette with headers' do
      VCR.use_cassette('sample vcr cassette') do
        uri = 'http://requestb.in/1cn93ai1'
        reesponse = HTTParty.post(uri, headers: { 'yan' => 'is awesome' })
      end
    end
  end
end
