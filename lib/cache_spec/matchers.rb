require_relative 'matchers/cache'

module CacheSpec
  module Matchers
    def cache_action(action)
      action = { :action => action } if action.is_a? Symbol
      Cache.new(action, controller)
    end

    def cache(name)
      Cache.new(name)
    end

    alias_method :cache_fragment, :cache
  end
end

# http://rspec.rubyforge.org/rspec/1.1.11/classes/Spec/Matchers.html
# How to make custom expectation matchers
#   class BeInZone
#     def initialize(expected)
#       @expected = expected
#     end
#     def matches?(target)
#       @target = target
#       @target.current_zone.eql?(Zone.new(@expected))
#     end
#     def failure_message
#       "expected #{@target.inspect} to be in Zone #{@expected}"
#     end
#     def negative_failure_message
#       "expected #{@target.inspect} not to be in Zone #{@expected}"
#     end
#   end
#   and a method like this:

#   def be_in_zone(expected)
#     BeInZone.new(expected)
#   end