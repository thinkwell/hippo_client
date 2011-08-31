require 'rubygems'

ENV['RAILS_ENV'] ||= 'test'

require 'vcr'
require 'hippo_client'

TEST_PRODUCT_ID = '4d76a704f7764853be000001'
TEST_COURSE_ID  = '4d76a706f7764853be000003'
TEST_ROOT_CONTAINER_ID = '4d76a704f7764853be000002'
TEST_CHILD_CONTAINER_ID = '4d76a707f7764853be000011'
TEST_CONTENT_ID = '4d76a707f7764853be00000b'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

VCR.config do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.stub_with :webmock
  c.default_cassette_options = {
    #:record => :new_episodes,
    :record => :none,
    :match_requests_on => [:method, :uri, :headers]
  }

  c.before_record do |i|
    i.request.headers['x-api-timestamp'] = /^[0-9]{10}$/
    i.request.headers['x-api-signature'] = /^[0-9a-f]{32}$/
  end
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
