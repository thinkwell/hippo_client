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

      response = fetch_uri(uri)

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

    private

    def fetch_uri(uri, redirect_limit=5)
      raise Errors::NetworkError.new(nil, 'Too many redirects') if redirect_limit == 0

      uri = URI.parse(uri) unless uri.is_a?(URI)
      request = Net::HTTP::Get.new(uri.request_uri)
      request['accept'] = 'application/json'
      if sign_uri?(uri)
        JohnHancock::Signature.sign!(options['signature']['algorithm'], request, options['signature']['options'] || {})
      end

      options = {:use_ssl => uri.scheme == 'https'}
      options[:verify_mode] = OpenSSL::SSL::VERIFY_NONE unless Rails.env.production?
      http = Net::HTTP.new(uri.host, uri.port, options)

      begin
        response = http.request(request)
      rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, Errno::ECONNREFUSED, EOFError,
             Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError, SocketError => e
        raise Errors::NetworkError, e
      end

      if response.is_a?(Net::HTTPRedirection)
        response = fetch_uri(response['location'], redirect_limit - 1)
      end

      response
    end

    def sign_uri?(request_uri)
      api_uri = URI.parse(options['url'])
      request_uri.host == api_uri.host
    end
  end
end
