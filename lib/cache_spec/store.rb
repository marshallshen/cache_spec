module CacheSpec
  class Store < ActiveSupport::Cache::Store
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
end