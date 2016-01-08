module Thinkwell::Hippo
  class Client
    # Defines all api calls related to containers
    module Content

      # Possible options:
      #   version
      def content(courseId, contentId, opts={})
        #path = courseId.nil? ? "content/#{contentId}" : "courses/#{courseId}/content/#{contentId}"
        path = "content/#{contentId}"
        hydrate :Content, fetch(path, opts)
      end

      # Possible options:
      #   version
      #   template
      #   parameters
      def contentView(courseId, contentId, format='html', opts={})
        #coursePath = (courseId ? "courses/#{courseId}/" : "")
        coursePath = ''
        fetch("#{coursePath}content/#{contentId}/view", opts, format)
      end

    end
  end
end
