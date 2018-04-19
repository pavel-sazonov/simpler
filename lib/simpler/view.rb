require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      return choose_renderer(template) if template.is_a? Hash

      template = File.read(template_path)

      ERB.new(template).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def choose_renderer(template)
      case template.keys.first
      when :plain
        Simpler::View::PlainRender.new(template).render
      when :html
        Simpler::View::HtmlRender.new(template).render
      end
    end

    def template_path
      path = template || [controller.name, action].join('/')
      @env["simpler.view"] = "#{path}.html.erb"

      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end

  end
end
