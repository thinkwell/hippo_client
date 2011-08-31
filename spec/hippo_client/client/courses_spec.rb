require 'spec_helper'

module Thinkwell
describe Hippo::Client do

  before(:each) do
    @client = hippo_client
  end

  describe "courses" do
    use_vcr_cassette
    it "returns an array of courses" do
      courses = @client.courses
      courses.should be_a Array
      courses[0].should be_a Hippo::Model::Course
    end

    it "filters courses by product" do
      courses = @client.courses({:product => TEST_PRODUCT_ID})
      courses.should be_a Array
      courses.should have(1).items
      courses[0].should be_a Hippo::Model::Course
    end
  end

  describe "course" do
    use_vcr_cassette
    it "returns a single course" do
      course = @client.course TEST_COURSE_ID
      course.should be_a Hippo::Model::Course
      course.id.should == TEST_COURSE_ID
    end

    it "raises an error for a course that doesn't exist" do
      expect { @client.course '4' }.to raise_error(Hippo::Errors::HippoError)
    end
  end

  describe "courseVersions" do
    use_vcr_cassette
    it "returns an array of course versions" do
      versions = @client.courseVersions(TEST_COURSE_ID)
      versions.should be_a Array
      versions[0].should be_a Hippo::Model::Course
    end
  end

end
end
