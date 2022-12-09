module Thinkwell::Hippo
  class Client
    # Defines all api calls related to courses
    module Courses

      # Possible options:
      #   product
      def courses(opts={})
        fetch('courses', opts)
      end

      # Possible options:
      #   version
      def course(courseId, opts={})
        hydrate :Course, fetch("courses/#{courseId}", opts)
      end

    end
  end
end
