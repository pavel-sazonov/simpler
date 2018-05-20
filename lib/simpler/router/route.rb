module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(env)
        method = env['REQUEST_METHOD'].downcase.to_sym
        path = env['PATH_INFO']

        @method == method && compare_paths(@path, path, env)
      end

      private

      def compare_paths(config_route_path, request_route_path, env)
        config_route_path = config_route_path.split('/')
        request_route_path = request_route_path.split('/')
        env['simpler.params'] = {}

        return false unless config_route_path.size == request_route_path.size

        config_route_path.each_with_index do |el, i|
          env['simpler.params'][el] = request_route_path[i] if el[0] == ':'

          return false if el != request_route_path[i] && el[0] != ':'
        end

        true
      end
    end
  end
end
