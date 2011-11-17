require 'spec_helper'

module Thinkwell
describe Hippo::Client do

  before(:each) do
    @client = hippo_client
  end

  describe "course_tree" do
    use_vcr_cassette

    it "raises an error for a course tree that doesn't exist" do
      expect { @client.course_tree('4') }.to raise_error(Hippo::Errors::HippoError)
    end

    context "in an existing course" do
      before(:each) do
        @tree = @client.course_tree(TEST_COURSE_ID)
      end

      it "returns the CourseTree object" do
        @tree.should be_a Hippo::Model::CourseTree
        @tree.id.should == TEST_COURSE_TREE_ID
      end

      it "has Node child nodes" do
        @tree.child_nodes.should be_a Array
        @tree.child_nodes[0].should be_a Hippo::Model::Node
      end
    end

  end
end
end
