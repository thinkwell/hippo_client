require 'spec_helper'

module Thinkwell
describe Hippo::Client do

  describe "initialize" do
    it "sets default options" do
      client = Hippo::Client.new
      client.options.should == Hippo.configuration
    end
  end
end
end
