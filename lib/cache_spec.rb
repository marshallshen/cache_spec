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

  class Store
    # TODO: build up mock cache stores
    attr_reader :cached, :expired, :data
    def initialize(options={})
      @data = {}
      @cached = []
      @expired = []
    end

    def reset #:nodoc
      [@data, @cached, @expired].map(&:clear)
    end

    def read_entry(name, options = nil) #:nodoc
      @data[name]
    end

    def write_entry(name, value, options = nil) # :nodoc
      @data[name] = value
      @cached << name
    end

    def expire_entry(name, options = nil) # :nodoc
      @expired << name
    end

    def cached?(name)
      @cached.include?(name)
    end

  end

  class Matchers
    # Implement matchers
  end
end
