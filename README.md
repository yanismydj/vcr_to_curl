# VcrToCurl
[![Build Status](https://travis-ci.org/yanismydj/vcr_to_curl.svg?branch=master)](https://travis-ci.org/yanismydj/vcr_to_curl)

Use this gem to convert vcr cassettes into curl commands.  Great for replaying requests in your tests

## Installation

Add this line to your application's Gemfile:

    gem 'VcrToCurl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install VcrToCurl

## Usage

`cassette_to_curl = VcrToCurl::CassetteToCurl.new('your_cassette_here.yml')`
`cassette_to_curl.curl_commands` => an array of curl commands for interactions in this cassette

## Contributing

1. Fork it ( https://github.com/[my-github-username]/VcrToCurl/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
