module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      return choose_renderer(template).new.render(template.first.last) if template.is_a? Hash

      template = File.read(template_path)
      Simpler::View::HtmlRender.new.render(template, binding)
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
      when :plain then Simpler::View::PlainRender
      when :html then Simpler::View::HtmlRender
      end
    end

    def template_path
      path = template || [controller.name, action].join('/')
      @env["simpler.view"] = "#{path}.html.erb"

      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end

  end
end
