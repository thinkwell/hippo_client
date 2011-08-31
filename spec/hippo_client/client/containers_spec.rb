require 'spec_helper'

module Thinkwell
describe Hippo::Client do

  before(:each) do
    @client = hippo_client
  end

  describe "container" do
    use_vcr_cassette
    it "returns the root container object" do
      container = @client.container(TEST_COURSE_ID, nil, {:depth => 0})
      container.should be_a Hippo::Model::Container
      container.descendants.should be_a Array
      container.id.should == TEST_ROOT_CONTAINER_ID
    end

    it "returns a specific container object" do
      container = @client.container(TEST_COURSE_ID, TEST_CHILD_CONTAINER_ID)
      container.should be_a Hippo::Model::Container
      container.id.should == TEST_CHILD_CONTAINER_ID
    end

    it "raises an error for a container that doesn't exist" do
      expect { @client.container(TEST_COURSE_ID, 4) }.to raise_error(Hippo::Errors::HippoError)
    end
  end

  describe "containerChildren" do
    use_vcr_cassette
    it "returns an array of container children for the root" do
      containers = @client.containerChildren(TEST_COURSE_ID)
      containers.should be_a Array
      containers[0].should be_a Hippo::Model::Container
    end

    it "returns an array of container children for a specific container" do
      containers = @client.containerChildren(TEST_COURSE_ID, TEST_CHILD_CONTAINER_ID)
      containers.should be_a Array
      containers[0].should be_a Hippo::Model::Container
    end

    it "filters by type" do
      containers = @client.containerChildren(TEST_COURSE_ID, nil, {:type => 'content'})
      containers.should be_a Array
      containers.should have(0).items
    end
  end

  describe "containerDescendants" do
    use_vcr_cassette
    it "returns an array of container descendants for the root" do
      containers = @client.containerDescendants(TEST_COURSE_ID, nil, {:depth => 1})
      containers.should be_a Array
      containers[0].should be_a Hippo::Model::Container
    end

    it "returns an array of container descendants for a specific container" do
      containers = @client.containerDescendants(TEST_COURSE_ID, TEST_CHILD_CONTAINER_ID)
      containers.should be_a Array
      containers[0].should be_a Hippo::Model::Container
    end
  end

  describe "containerContent" do
    use_vcr_cassette
    it "returns an array of content containers for the root" do
      containers = @client.containerContent(TEST_COURSE_ID)
      containers.should be_a Array
      containers[0].should be_a Hippo::Model::Container
      containers[0].type.should == 'content'
      containers[0].parent_container.should be_a Hippo::Model::Container
    end

    it "returns an array of content containers for a specific container" do
      containers = @client.containerContent(TEST_COURSE_ID, TEST_CHILD_CONTAINER_ID)
      containers.should be_a Array
      containers[0].should be_a Hippo::Model::Container
    end
  end

end
end
