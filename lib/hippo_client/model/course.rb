module Thinkwell::Hippo
  module Model
    class Course
      include HashInitialize
      attr_accessor :id, :name, :product_id, :created_at
    end
  end
end
