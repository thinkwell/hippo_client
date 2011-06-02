module Thinkwell::ContentRepository
  class Subject
    include HashInitialize
    attr_accessor :id, :name
  end
end
