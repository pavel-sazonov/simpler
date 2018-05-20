require 'erb'

module Simpler
  class View
    class HtmlRender
      def render(template, binding=nil)
        ERB.new(template).result(binding)
      end
    end
  end
end
