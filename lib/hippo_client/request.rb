require 'net/http'
require 'net/https'
require 'uri'
require 'john-hancock'
require 'john-hancock/request_proxy/net_httprequest'
require 'json'
require 'active_support/core_ext/object/conversions'
require 'active_support/core_ext/array'
require 'active_support/core_ext/hash'

module Thinkwell::Hippo
  # Defines HTTP request methods
  module Request

    protected

    def fetch(method, params={}, format='json')
      raise Errors::HippoError.new('Cannot find url option') unless options['url']

      uri = URI.parse("#{options['url']}/#{method}#{format.nil? ? '' : ".#{format}"}")
      uri.query = params.to_query unless params.empty?

      request = Net::HTTP::Get.new(uri.request_uri)
      request['accept'] = 'application/json'
      JohnHancock::Signature.sign!(options['signature']['algorithm'], request, options['signature']['options'] || {})

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
        raise Errors::HippoError, "An error occurred while fetching data from hippo.\n" + (message ? "Error: #{message}" : "#{response.code}: #{response.message}")
      end

      if response.content_type == 'application/json'
        ::JSON.parse(response.body)
      else
        response.body
      end
    end
  end
end
