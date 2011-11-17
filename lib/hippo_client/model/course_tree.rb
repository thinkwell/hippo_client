module Thinkwell::Hippo
  module Model
    class CourseTree
      include HashInitialize
      attr_accessor :id, :child_nodes, :created_at, :updated_at

      def child_nodes=(value)
        value = value.map do |v|
          v.is_a?(Hash) ? Node.new(v) : v
        end if value.is_a?(Array)
        @child_nodes = value
      end

    end
  end
end
