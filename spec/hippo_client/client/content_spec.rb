require 'spec_helper'

module Thinkwell
describe Hippo::Client do

  before(:each) do
    @client = hippo_client
  end

  describe "content" do
    use_vcr_cassette
    it "returns a content object" do
      content = @client.content(TEST_COURSE_ID, TEST_CONTENT_ID)
      content.should be_a Hippo::Model::Content
      content.id.should == TEST_CONTENT_ID
    end

    it "raises an error if the content doesn't exist" do
      expect { @client.content(TEST_COURSE_ID, 4) }.to raise_error(Hippo::Errors::HippoError)
    end
  end

  describe "contentView" do
    use_vcr_cassette
    it "returns an html view" do
      content = @client.contentView(TEST_COURSE_ID, TEST_CONTENT_ID)
      content.should be_a String
    end

    it "follows redirects" do
      content = @client.contentView(TEST_COURSE_ID, TEST_CONTENT_ID, 'html', :template => 'transcript')
      content.should be_a String
      content.should =~ /<h3>An Introduction to Calculus/
    end
  end
end
end
