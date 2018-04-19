module Simpler
  class View
    class HtmlRender
      def initialize(template)
        @template = template
      end

      def render
        @template[:html]
      end
    end
  end
end
