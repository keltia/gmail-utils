# tags_spec.rb
#
# @author Ollivier Robert <roberto@keltia.net> 
#
# $Id: tags_spec.rb,v 97488c700e02 2012/12/05 00:12:56 roberto $

require "rspec"

require "gmail/tags"

describe GMail::TagList do

  before(:all) do
    @tl = GMail::TagList.new
    @t = GMail::Tag.new("Foo")
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
      @tl.add(@t)
      @tl.include?(@t).should be_true
    end
  end

  describe "#<<" do
    it "should add one element to the list"
  end

  describe "#each" do
    it "iterate on all members of @list"
    it "each element should of class Tag"
  end

  describe "#length" do
    it "should have the right length" do
      @tl.length.should eq(@tl.list.length)
    end
  end
end