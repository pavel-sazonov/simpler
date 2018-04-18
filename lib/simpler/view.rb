require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      return template.first.last if template.is_a? Hash

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
      @env['simpler.template'] # plain: 'text'
    end

    def template_path
      path = template || [controller.name, action].join('/')
      @env["simpler.view"] = "#{path}.html.erb" unless template.is_a? Hash

      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end

  end
end
