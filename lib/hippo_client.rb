module Thinkwell
  module Hippo
    autoload :Client,             'hippo_client/client'
    autoload :HashInitialize,     'hippo_client/hash_initialize'
    autoload :Request,            'hippo_client/request'
    autoload :Hydrate,            'hippo_client/hydrate'

    module Model
      autoload :Product,          'hippo_client/model/product'
      autoload :Course,           'hippo_client/model/course'
      autoload :Container,        'hippo_client/model/container'
      autoload :Content,          'hippo_client/model/content'
    end

    module Errors
      autoload :HippoError,       'hippo_client/errors/hippo_error'
      autoload :NetworkError,     'hippo_client/errors/network_error'
    end


    def self.client(options={})
      Client.new(options)
    end

    def self.configure(options)
      @configuration = default_options.merge(options)
    end

    def self.configuration
      @configuration || default_options
    end

    def self.default_options
      {
        'signature' => {
          'algorithm' => 'simple',
          'options'   => {},
        }
      }
    end

  end
end
