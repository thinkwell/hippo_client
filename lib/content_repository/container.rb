module Thinkwell::ContentRepository
  class Container
    include HashInitialize
    attr_accessor :id, :depth, :type, :parent_id, :root_id, :number, :name, :descendants

    def descendants=(value)
      value = value.map do |v|
        v.is_a?(Hash) ? Container.new(v) : v
      end if value.is_a?(Array)
      @descendants = value
    end

  end
end
