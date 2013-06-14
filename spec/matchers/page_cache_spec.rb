require 'spec_helper'

describe CacheSpec::Matchers::CachePage do
  class MocksController < ActionController::Base
    # BUG
    #caches_page :index

    def index
      #TODO
    end

    def show
      #TODO
    end
  end

  it "should match the cached page" do
    it "should cache the page" do
      lambda { get :index }.should cache_page('/products') # this is page url
    end
  end

  it "should not match the non-cached page" do
     lambda { get :show, 1 }.should_not cache_page('/products') # this is page url
  end
end