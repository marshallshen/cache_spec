module CacheSpec
  module Matchers
    class Cache
      def initialize(name, controller=nil)
        @name = name
        @controller = controller
      end

      def matches?(block)
        block.call
        @key = @name.is_a?(String) ? @name : @controller.fragment_cache_key(@name)
        ActionController::Base.cache_store.cached?(@key)
      end

      def failure_message
        "Expected #{@controller} to cache #{@name}"
      end

      def negative_failure_message
        "Expected #{@controller} to not cache #{@name}"
      end
    end
  end
end