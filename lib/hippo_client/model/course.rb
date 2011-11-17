module Thinkwell::Hippo
  module Model
    class Course
      include HashInitialize
      attr_accessor :id, :name, :product_id, :container_id, :created
    end
  end
end
