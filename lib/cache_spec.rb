require 'cache_spec/store'

module CacheSpec
  def self.setup
    # Turn on caching
    ActionController::Base.perform_caching = true
    # Hook into the fragment and page caching mechanisms
    ActionController::Base.cache_store = CacheSpec::Store.new
    ActionController::Base.class_eval do
      #include RspecCachingTest::CacheTest::PageCaching
    end
    # Make our matchers available to rspec via Test::Unit
    RSpec::Matchers.class_eval do
      include Matchers
    end
  end

  module Matchers
    class CachePage
      def initialize(url)
        @url = url
        ActionController::Base.reset_page_cache!
      end

      def matches?(block)
        block.call
        ActionController::Base.cached?(@url)
      end

      def failure_message_for_should
        "Expected to cache the page #{@url.inspect}"
      end

      def failure_message_for_should_not
        "Expected not to cache the page #{@url.inspect}"
      end
    end
  end
end
