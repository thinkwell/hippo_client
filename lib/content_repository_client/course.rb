module Thinkwell::ContentRepository
  class Course
    include HashInitialize
    attr_accessor :id, :name, :product_id, :version, :container_id, :created
  end
end
