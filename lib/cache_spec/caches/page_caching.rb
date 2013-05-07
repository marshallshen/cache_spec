module CacheSpec::Caches
  module PageCaching

    def self.included(klass) #:nodoc:
      klass.class_eval do
        cattr_accessor :cached_pages, :expired_pages
        @@cached_pages = []; @@expired_pages = []
      end
      klass.extend ClassMethods
      klass.send :include, InstanceMethods
    end

    module ClassMethods
      # Step 1: get the path working, develop the sign
      # Step 2: make it able to verify the content inside cache
      def cache_page(content, path)
        cached_pages << path
      end

      def expire_page(path)
        expired_pages << path
      end

      def cached?(path)
        cached_pages.include?(path)
      end

      def expired?(path)
        expired_pages.include?(path)
      end

      def reset_page_cache!
        cached_pages.clear
        expired_pages.clear
      end
    end

    module InstanceMethods
      # See if the page caching mechanism has cached a given url. This takes
      # the same options as +url_for+.
      def cached?(options = {})
        self.class.cached?(cache_url(options))
      end

      # See if the page caching mechanism has expired a given url. This
      # takes the same options as +url_for+.
      def expired?(options = {})
        self.class.expired?(cache_url(options))
      end

      private

      def cache_url(options) #:nodoc:
        url_for(options.merge({ :only_path => true, :skip_relative_url_root => true }))
      end
    end
  end
end