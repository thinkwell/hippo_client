class ThinkwellRepository
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
    fetch('subjects')
  end


  # Possible options:
  #   subject
  def courses(opts={})
    fetch('courses', opts)
  end


  # Possible options:
  #   version
  def course(courseId, opts={})
    fetch("courses/#{courseId}", opts)
  end


  def courseVersions(courseId)
    fetch("courses/#{courseId}/versions")
  end


  # Possible options:
  #   depth
  #   type
  def container(containerId, opts={})
    fetch("containers/#{containerId}", opts)
  end


  # Possible options:
  #   type
  def containerChildren(containerId, opts={})
    fetch("containers/#{containerId}/children", opts)
  end


  # Possible options:
  #   depth
  #   type
  def containerDescendants(containerId, opts={})
    fetch("containers/#{containerId}/descendants", opts)
  end


  # Possible options:
  #   depth
  #   format
  #   type
  def containerContent(containerId, opts={})
    fetch("containers/#{containerId}/content", opts)
  end


  # Possible options:
  #   version
  #   parameters
  def contentView(contentId, containerId, opts={})
    fetch("content/#{contentId}/view", opts.merge({:container => containerId}))
  end


  # Possible options:
  #   version
  #   parameters
  def contentPreview(contentId, containerId, opts={})
    fetch("content/#{contentId}/preview", opts.merge({:container => containerId}))
  end


  protected

  def fetch(method, params={})
    config = self.class.config

    uri = URI.parse("#{config[:url]}/#{config[:version]}/#{method}.json")
    uri.query = params.to_query unless params.empty?

    request = Net::HTTP::Get.new(uri.request_uri)
    request['accept'] = 'application/json'
    JohnHancock::Signature.sign!(config[:signature][:algorithm], request, config[:signature][:options])

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'

    response = http.request(request)

    if response.code.to_i != 200
      # TODO: Throw a better exception
      message = JSON.parse(response.body)['message'] rescue nil
      raise RuntimeError, "An error occurred while fetching data from the repository." + (message ? "\nError: #{message}" : "")
    end

    JSON.parse(response.body)
  end

end
