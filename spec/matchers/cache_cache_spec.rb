require 'spec_helper'

describe CacheSpec::Matchers::Cache do
  before do
    @cache_matcher = CacheSpec::Matchers::Cache.new('/index', 'MockController')
  end

  it "initializes with cache name and controller" do
    @cache_matcher.instance_variable_get('@name').should == '/index'
    @cache_matcher.instance_variable_get('@controller').should == 'MockController'
  end

  it "calls out to cache store to search for value" do
    CacheSpec::Store.any_instance.should_receive(:cached?)
    @cache_matcher.matches?(Proc.new {|arg| puts arg})
  end
end