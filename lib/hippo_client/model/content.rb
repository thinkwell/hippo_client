module Thinkwell::Hippo
  module Model
    class Content
      include HashInitialize
      attr_accessor :id, :format, :type, :name, :view
    end
  end
end
