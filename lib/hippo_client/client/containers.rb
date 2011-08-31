module Thinkwell::Hippo
  class Client
    # Defines all api calls related to containers
    module Containers

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
      def containerContent(courseId, containerId=nil, opts={})
        containerIdStr = containerId ? "/#{containerId}" : ""
        hydrate :Container, fetch("courses/#{courseId}/containers#{containerIdStr}/content", opts)
      end

    end
  end
end
