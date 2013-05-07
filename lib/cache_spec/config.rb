module CacheSpec
  module Config
    def setup
      # Turn on caching
      ActionController::Base.perform_caching = true

      # Hook into the fragment and page caching mechanisms
      ActionController::Base.cache_store = CacheSpec::Store.new
      ActionController::Base.class_eval do
        include CacheSpec::ActionCaching
        include CacheSpec::FragmentCaching
        include CacheSpec::PageCaching
      end

      # Make our matchers available to rspec via Test::Unit
      RSpec::Matchers.class_eval do
        include Matchers
      end
    end
  end
end