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
      #   template
      #   parameters
      def contentView(courseId, contentId, format='html', opts={})
        coursePath = (courseId ? "courses/#{courseId}/" : "")
        fetch("#{coursePath}content/#{contentId}/view", opts, format)
      end

    end
  end
end
