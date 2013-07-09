require 'rspec/rails'

require_relative 'cache_spec/store'
require_relative 'cache_spec/matchers'

module CacheSpec
  ActionController::Base.perform_caching = true
  ActionController::Base.cache_store = CacheSpec::Store.new

  RSpec::Matchers.class_eval do
    include Matchers
  end
  # ActionController::Base.class_eval do
  #   include CacheSpec
  # end
end