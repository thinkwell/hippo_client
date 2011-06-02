module Thinkwell
  module ContentRepository
    autoload :HashInitialize, 'content_repository_client/hash_initialize'
    autoload :Repository,     'content_repository_client/repository'
    autoload :Product,        'content_repository_client/product'
    autoload :Course,         'content_repository_client/course'
    autoload :Container,      'content_repository_client/container'
    autoload :Content,        'content_repository_client/content'

    module Errors
      autoload :RepositoryError,   'content_repository_client/errors/repository_error'
      autoload :NetworkError,      'content_repository_client/errors/network_error'
    end
  end
end
