require 'spec_helper'

module Thinkwell
describe Hippo::Client do

  before(:each) do
    @client = hippo_client
  end

  describe "products" do
    use_vcr_cassette
    it "returns an array of products" do
      products = @client.products
      products.should be_a Array
      products[0].should be_a Hippo::Model::Product
    end
  end

  describe "product" do
    use_vcr_cassette
    it "returns a single product" do
      product = @client.product(TEST_PRODUCT_ID)
      product.should be_a Hippo::Model::Product
    end

    it "raises an error for a product that doesn't exist" do
      expect { @client.product '4' }.to raise_error(Hippo::Errors::HippoError)
    end
  end
end
end
