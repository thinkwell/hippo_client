module Thinkwell::ContentRepository
  class Container
    include HashInitialize
    attr_accessor :id, :depth, :type, :parent_id, :root_id, :number, :name, :descendants,
      :content_id, :content_version, :meta, :parent_container

    def descendants=(value)
      value = value.map do |v|
        v.is_a?(Hash) ? Container.new(v) : v
      end if value.is_a?(Array)
      @descendants = value
    end

    def parent_container=(value)
      @parent_container = value.is_a?(Hash) ? Container.new(value) : value
    end

  end
end
