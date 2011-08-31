module Thinkwell::Hippo
  class Client
    # Defines all api calls related to courses
    module Courses

      # Possible options:
      #   product
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

    end
  end
end
