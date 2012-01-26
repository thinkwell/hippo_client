require 'spec_helper'

module Thinkwell
describe Hippo do

  describe "configuration" do
    it "uses default options" do
      Hippo.configuration.should == Hippo.default_options
    end

    it "merges defaults when setting options" do
      Hippo.configure 'foo' => 'bar'
      Hippo.configuration.should == Hippo.default_options.merge({'foo' => 'bar'})
    end

    it "sets signature options" do
      opts = {
        'signature' => {
          'algorithm' => 'simple',
          'options' => {
            'key' => 'mykey',
            'secret' => 'mysecret',
            'key_header' => 'X-My-Key',
            'signature_header' => 'X-My-Signature',
            'timestamp_header' => 'X-My-Timestamp',
          },
        },
      }
      Hippo.configure opts
      Hippo.configuration.should == Hippo.default_options.merge(opts)
    end
  end

  describe "client" do
    it "instantiates a new client object" do
      Hippo.client.should be_a Hippo::Client
    end
  end
end
end
