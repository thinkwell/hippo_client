module Thinkwell::Hippo
  module Model
    class Course
      include HashInitialize
      attr_accessor :id, :name, :product_id, :mapleta_parent_id, :created_at
    end
  end
end
