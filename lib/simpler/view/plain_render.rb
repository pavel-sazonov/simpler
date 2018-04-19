module Simpler
  class View
    class PlainRender
      def initialize(template)
        @template = template
      end

      def render
        @template[:plain]
      end
    end
  end
end
