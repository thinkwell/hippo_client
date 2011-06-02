module Thinkwell::ContentRepository
  class Content
    include HashInitialize
    attr_accessor :id, :format, :type, :name, :view
  end
end
