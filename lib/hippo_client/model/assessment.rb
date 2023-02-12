module Thinkwell::Hippo
  module Model
    class Assessment
      include HashInitialize
      attr_accessor :id, :name, :main_header, :sub_header, :examples, :tags
    end
  end
end
