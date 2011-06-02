module Thinkwell::ContentRepository
  class Course
    include HashInitialize
    attr_accessor :id, :name, :subject_id, :version, :container_id, :created
  end
end
