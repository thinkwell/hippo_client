module Thinkwell::Hippo
  module Model
    class CourseTree
      include HashInitialize
      include Enumerable
      attr_accessor :id, :child_nodes, :created_at, :updated_at

      def child_nodes=(value)
        value = value.map do |v|
          v.is_a?(Hash) ? Node.new(v) : v
        end if value.is_a?(Array)
        @child_nodes = value
      end


      # Iterates over all nodes in depth-first order
      def each
        each_with_depth {|node, depth| yield node }
      end

      # Iterates over all nodes in depth-first order
      # including the depth of each node (starting at depth=0)
      def each_with_depth
        fn = lambda do |child_nodes, depth|
          child_nodes.each do |node|
            yield node, depth
            fn.call(node.child_nodes, depth+1) if node.child_nodes
          end
        end

        fn.call(self.child_nodes, 0)
      end

    end
  end
end
