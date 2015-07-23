module Thinkwell::Hippo
  module Model
    class Content
      include HashInitialize
      attr_accessor :id, :format, :type, :name,
                    # BookRange
                    :start_page, :end_page, :book_id,
                    # VideoLecture
                    :video_id, :part_id, :subject, :width, :height, :duration, :transcript_html, :transcript_pdf, :transcript_swf,
                    # Maple
                    :maple_class_id, :maple_assignment_id, :maple_extra_assignment_ids, :gradebook,
                    # SampleProblemCollection
                    :sample_problem_ids, :video_ids,
                    # WolframCdf
                    :wolfram_id, :signature, :width, :height,
                    # CanvasQuiz
                    :context_id, :context_type, :quiz_id, :quiz_type
      # TODO: Clean this up. Split content into their own content types. Make field assignment dynamic.
    end
  end
end
