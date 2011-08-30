module Thinkwell::ContentRepository
  class Product
    include HashInitialize
    attr_accessor :id, :name, :default_course_id, :mapleta_parent_id
  end
end
