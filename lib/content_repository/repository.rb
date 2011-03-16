module Thinkwell::ContentRepository
  class Repository
    require 'net/http'
    require 'net/https'
    require 'uri'
    require 'john-hancock'
    require 'john-hancock/request_proxy/net_httprequest'

    def self.config
      return @config if defined?(@config)
      @config ||= (HashWithIndifferentAccess.new(YAML.load_file(RAILS_ROOT + "/config/thinkwell_repository.yml")[RAILS_ENV]) rescue nil)

      raise RuntimeError, "Can't find configuration for the Thinkwell Content Repository.  Check your thinkwell_repository.yml configuration file." unless @config
      @config
    end


    def subjects
      hydrate :Subject, fetch('subjects')
    end


    # Possible options:
    #   subject
    def courses(opts={})
      hydrate :Course, fetch('courses', opts)
    end


    # Possible options:
    #   version
    def course(courseId, opts={})
      hydrate :Course, fetch("courses/#{courseId}", opts)
    end


    def courseVersions(courseId)
      hydrate :Course, fetch("courses/#{courseId}/versions")
    end


    # Possible options:
    #   depth
    #   type
    def container(courseId, containerId=nil, opts={})
      containerIdStr = containerId ? "/#{containerId}" : ""
      hydrate :Container, fetch("courses/#{courseId}/containers#{containerIdStr}", opts)
    end


    # Possible options:
    #   type
    def containerChildren(courseId, containerId=nil, opts={})
      containerIdStr = containerId ? "/#{containerId}" : ""
      hydrate :Container, fetch("courses/#{courseId}/containers#{containerIdStr}/children", opts)
    end


    # Possible options:
    #   depth
    #   type
    def containerDescendants(courseId, containerId=nil, opts={})
      containerIdStr = containerId ? "/#{containerId}" : ""
      hydrate :Container, fetch("courses/#{courseId}/containers#{containerIdStr}/descendants", opts)
    end


    # Possible options:
    #   depth
    #   format
    #   type
    def containerContent(courseId, containerId=nil, opts={})
      containerIdStr = containerId ? "/#{containerId}" : ""
      hydrate :Container, fetch("courses/#{courseId}/containers#{containerIdStr}/content", opts)
    end


    # Possible options:
    #   version
    #   parameters
    def contentView(courseId, contentId, opts={})
      hydrate :Content, fetch("courses/#{courseId}/content/#{contentId}/view", opts)
    end


    # Possible options:
    #   version
    #   parameters
    def contentPreview(courseId, contentId, opts={})
      hydrate :Content, fetch("courses/#{courseId}/content/#{contentId}/preview", opts)
    end


    protected

    def fetch(method, params={}, format='json')
      config = self.class.config

      uri = URI.parse("#{config[:url]}/#{config[:version]}/#{method}#{format.nil? ? '' : ".#{format}"}")
      uri.query = params.to_query unless params.empty?

      request = Net::HTTP::Get.new(uri.request_uri)
      request['accept'] = 'application/json'
      JohnHancock::Signature.sign!(config[:signature][:algorithm], request, config[:signature][:options])

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      begin
        response = http.request(request)
      rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, Errno::ECONNREFUSED, EOFError,
             Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
        raise Errors::NetworkError, e
      end

      if response.code.to_i != 200
        # TODO: Throw a better exception
        message = JSON.parse(response.body)['message'] rescue nil
        raise Errors::RepositoryError, "An error occurred while fetching data from the repository.\n" + (message ? "Error: #{message}" : "#{response.code}: #{response.message}")
      end

      if response.content_type == 'application/json'
        JSON.parse(response.body)
      else
        response.body
      end
    end


    def hydrate(type, data)
      klass = "Thinkwell::ContentRepository::#{type.to_s.camelize}".constantize
      if data.is_a?(Array)
        data.map { |obj| klass.new(obj) }
      elsif data.is_a?(Hash)
        klass.new(data)
      else
        nil
      end
    end
  end
end
