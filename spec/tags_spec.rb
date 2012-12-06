# tags_spec.rb
#
# @author Ollivier Robert <roberto@keltia.net> 
#
# $Id: tags_spec.rb,v b355ddc30947 2012/12/06 14:04:02 roberto $

require "rspec"

require "gmail/tags"

describe GMail::TagList do

  before(:all) do
    @tl = GMail::TagList.new
    @t = GMail::Tag.new("Foo")
    @tlk = [ @t ]
    @tlkl = { "Foo" => 1 }
  end

  describe "#initialize" do
    it "should define a new object" do
      @tl.should_not be_nil
    end

    it "should be of the right class of course" do
      @tl.should be_an_instance_of(GMail::TagList)
    end

    it "should have an empty Hash as .list" do
      @tl.list.should be_an_instance_of(Hash)
    end
  end

  describe "#add" do
    it "should add one element to the list" do
      @tl.add(@t1)
      @tl.keys.should eq(@tl1.keys)
      @tl.include?(@t1).should be_true
    end

    it "adding an already present Tag should increment the counter" do
      @tl.add(@t1)
      @tl.keys.should eq(@tl2.keys)
      @tl.list[@t1].should eq(2)
    end
  end

  describe "#<<" do
    it "should add one element to the list" do
      @tl << @t1
      @tl.keys.should eq(@tl1.keys)
      @tl.include?(@t1).should be_true
    end
  end

  describe "include?" do
    it "should return true for an element of the list" do
      @tl.include?(@t).should be_true
    end
  end

  describe "#keys" do
    it "should return all keys." do
      @tl.keys.should be_an_instance_of(Array)
      @tl.keys.should_not be_nil
      @tl.keys.should eq(@tlk)
    end
  end

  describe "#each" do
    it "iterate on all members of @list" do
      t = Array.new
      @tl3.each do |e|
        t << e
      end
      t.should eq(@tlk3)
    end

    it "each element should of class Tag" do
      @tl3.each do |t|
        t.should be_an_instance_of(GMail::Tag)
      end
    end
  end

  describe "#[]" do
    it "should return the counter for the given tag" do
      @tl3 << @t1
      @tl3[@t1].should eq(2)
    end
  end

  describe "#[]=" do
    it "should set the given counter" do
      @tl3[@t1] = 42
      @tl3[@t1].should eq(42)
    end
  end

  describe "#length" do
    it "should have the right length" do
      @tl.length.should eq(@tl.list.length)
    end
  end
end