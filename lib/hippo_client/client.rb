module Thinkwell::Hippo
  class Client

    attr_reader :options

    def initialize(options={})
      @options = ::Thinkwell::Hippo.configuration.merge(options)
    end


    require 'hippo_client/client/products'
    require 'hippo_client/client/courses'
    require 'hippo_client/client/containers'
    require 'hippo_client/client/content'

    include Client::Products
    include Client::Courses
    include Client::Containers
    include Client::Content


    include Request
    include Hydrate

  end
end
