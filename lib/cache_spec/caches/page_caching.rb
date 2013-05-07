module CacheSpec::Caches
  module PageCaching

    def self.included(klass) #:nodoc:
      klass.class_eval do
        @@test_page_cached = [] # keep track of what gets cached
        @@test_page_expired = [] # keeg track of what gets expired
        cattr_accessor :test_page_cached
        cattr_accessor :test_page_expired
      end
      klass.extend ClassMethods
      klass.send :include, InstanceMethods
    end

    module ClassMethods
      def cache_page(content, path)
        test_page_cached << path
      end

      def expire_page(path)
        test_page_expired << path
      end

      def cached?(path)
        test_page_cached.include?(path)
      end

      def expired?(path)
        test_page_expired.include?(path)
      end

      def reset_page_cache!
        test_page_cached.clear
        test_page_expired.clear
      end
    end

    module InstanceMethods
      # See if the page caching mechanism has cached a given url. This takes
      # the same options as +url_for+.
      def cached?(options = {})
        self.class.cached?(test_cache_url(options))
      end

      # See if the page caching mechanism has expired a given url. This
      # takes the same options as +url_for+.
      def expired?(options = {})
        self.class.expired?(test_cache_url(options))
      end

      private

      def test_cache_url(options) #:nodoc:
        url_for(options.merge({ :only_path => true, :skip_relative_url_root => true }))
      end
    end
  end
end