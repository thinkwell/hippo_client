module Thinkwell::Hippo
  module Model
    class Node
      include HashInitialize
      attr_accessor :id, :name, :number, :book_number, :type, :content_id, :content_name, :book_content_id, :content_version, :meta, :child_nodes

      def child_nodes=(value)
        value = value.map do |v|
          v.is_a?(Hash) ? Node.new(v) : v
        end if value.is_a?(Array)
        @child_nodes = value
      end

    end
  end
end
