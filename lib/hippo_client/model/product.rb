module Thinkwell::Hippo
  module Model
    class Product
      include HashInitialize
      attr_accessor :id, :name, :default_course_id, :created_at, :updated_at
    end
  end
end
