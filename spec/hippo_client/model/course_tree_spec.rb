require 'spec_helper'

module Thinkwell::Hippo::Model
describe CourseTree do

  before(:each) do
    @tree = CourseTree.new({
      :id => '1',
      :child_nodes => [
        {:id => '1', :name => '1', :number => '1', :child_nodes => [
          {:id => '2', :name => '1.1', :number => '1.1', :child_nodes => [
            {:id => '3', :name => '1.1.1', :number => '1.1.1'},
          ]}
        ]},
        {:id => '4', :name => '2', :number => '2', :child_nodes => [
          {:id => '5', :name => '2.1', :number => '2.1'},
          {:id => '6', :name => '2.7', :number => '2.7'},
        ]},
      ]
    })
  end


  context "#each" do
    it "iterates through the tree using depth-first ordering" do
      ary = []
      @tree.each {|node| ary << node.id.to_i}
      ary.should == [1,2,3,4,5,6]
    end

    it "supports breaking the iterator" do
      ary = []
      @tree.each do |node|
        ary << node.id.to_i
        break if node.id == '3'
      end
      ary.should == [1,2,3]
    end
  end

  context "#each_with_depth" do
    it "includes the depth of each node" do
      ary = []
      @tree.each_with_depth {|node, depth| ary << depth}
      ary.should == [0, 1, 2, 0, 1, 1]
    end

    it "includes the parent node of each node" do
      ary = []
      @tree.each_with_depth {|node, depth, parent_node| ary << (parent_node.nil? ? nil : parent_node.id.to_i)}
      ary.should == [nil, 1, 2, nil, 4, 4]
    end
  end

  context "#map" do
    it "iterates over the tree in depth-first order" do
      @tree.map {|node| node.id.to_i}.should == [1,2,3,4,5,6]
    end
  end

end
end
