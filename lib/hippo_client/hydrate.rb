module Thinkwell::Hippo
  # Defines model hydration methods
  module Hydrate

    protected

    def hydrate(type, data)
      klass = "Thinkwell::Hippo::Model::#{type.to_s.camelize}".constantize
      if data.is_a?(Array)
        data.map { |obj| klass.new(obj) }
      elsif data.is_a?(Hash)
        klass.new(data)
      else
        nil
      end
    end

  end
end
