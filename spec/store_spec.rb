require 'spec_helper'

describe CacheSpec::Store do
  it "has cached store" do
    subject.cached.should == []
  end

  it "has expired store" do
    subject.expired.should == []
  end

  it "stores data in a hash" do
    subject.data.should == {}
  end

  describe "basic operations" do
    before do
      subject.write_entry(:foo, :bar)
    end

    it "writes entry to cache" do
      subject.cached.size.should == 1
    end

    it "reads entry to cache" do
      subject.read_entry(:foo).should == :bar
    end

    it "expires entry from cache" do
      subject.expire_entry(:foo)
      subject.expired.size.should == 1
    end

    it "query if cache is included" do
      subject.cached?(:foo).should == true
    end
  end
end