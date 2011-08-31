module Thinkwell::Hippo
  class Client
    # Defines all api calls related to containers
    module Content

      # Possible options:
      #   version
      def content(courseId, contentId, opts={})
        hydrate :Content, fetch("courses/#{courseId}/content/#{contentId}", opts)
      end

      # Possible options:
      #   version
      #   parameters
      def contentView(courseId, contentId, format='html', opts={})
        fetch("courses/#{courseId}/content/#{contentId}/view", opts, format)
      end

    end
  end
end
