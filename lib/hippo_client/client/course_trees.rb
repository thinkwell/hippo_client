module Thinkwell::Hippo
  class Client
    # Defines all api calls related to course trees
    module CourseTrees

      def course_tree(courseId, opts={})
        hydrate :CourseTree, fetch("courses/#{courseId}/tree", opts)
      end

    end
  end
end
