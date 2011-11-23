require 'rubygems'

ENV['RAILS_ENV'] ||= 'test'

require 'vcr'
require 'hippo_client'

TEST_PRODUCT_ID = '4d76a704f7764853be000001'
TEST_COURSE_ID  = '4d76a706f7764853be000003'
TEST_COURSE_TREE_ID = '4ecc221d043260118e000002'
TEST_CONTENT_ID = '4d76a707f7764853be00000b'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.register_request_matcher :john_hancock_headers do |r1, r2|
    jh_headers = lambda do |key, val|
      (key == 'X-Api-Timestamp' && val.to_s =~ /^[0-9]{10}$/) ||
        (key == 'X-Api-Signature' && val.to_s =~ /^[0-9a-f]{32}$/)
    end

    (r1.headers.reject &jh_headers) == (r2.headers.reject &jh_headers)
  end
  c.default_cassette_options = {
    #:record => :new_episodes,
    :record => :none,
    :match_requests_on => [:method, :uri, :john_hancock_headers]
  }
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end

def hippo_client
  Thinkwell::Hippo.client(
    'url' => 'http://localhost:3000',
    'signature' => {
      'algorithm' => 'simple',
      'options' => {
        'key' => '4d26276a99cf2b1291000001',
        'secret' => 'MySeCRET',
      },
    }
  )
end
