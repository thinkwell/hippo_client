module Thinkwell::Hippo
  class Client
    # Defines all api calls related to assessments
    module Assessments

      def assessments(opts={})
        fetch('assessments', opts)
      end

      def assessment(assessmentId, opts={})
        fetch("assessments/#{assessmentId}", opts)
      end

    end
  end
end
