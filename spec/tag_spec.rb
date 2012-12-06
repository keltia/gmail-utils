# @abstract Tag handling and conversion specs
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: tag_spec.rb,v 1e1c49ee1b7c 2012/12/06 13:03:40 roberto $

require "rspec"
require "gmail"

class DataError < Exception; end

describe GMail::Tag do

  before(:all) do
    @tags = [ "Perso", "Perso/Foo" ]
    @tag1 = GMail::Tag.new(@tags[0])
    @tag2 = GMail::Tag.new(@tags[1])
  end

  describe "#initialize" do

    it "should raise an exception if @tag is nil" do
      expect{@tag = GMail::Tag.new}.to raise_error(ArgumentError)
    end

    it "should create a @tag object" do
      @tag1.should_not be_nil
      @tag2.should_not be_nil
      @tag1.should be_an_instance_of(GMail::Tag)
      @tag2.should be_an_instance_of(GMail::Tag)
    end

    it "should have a label member" do
      @tag1.label.should be_instance_of(String)
      @tag2.label.should be_instance_of(String)
    end

    it "should have the right label value" do
      @tag1.label.should == "Perso"
      @tag2.label.should == "Perso/Foo"
    end
  end

  describe "#to_s" do
    it "should keep the right value if no '/'" do
      @tag1.to_s.should == "Perso"
    end

    it "should convert '/' into '-'" do
      @tag2.to_s.should == "Perso-Foo"
    end

    it "should be used as default method when using the object" do
      @tag1.to_s.should == "#{@tag1}"
      @tag2.to_s.should == "#{@tag2}"
    end
  end

  describe "#match" do
    it "should not match the '' (null) tag" do
      @tag1.match('').should be_false
      @tag2.match('').should be_false
    end

    it "should match the correct tag" do
      @tag1.match("Perso/Foo").should be_false
      @tag2.match("Perso/Foo").should_not be_false
    end
  end

  describe "#<=>" do
    it "should compare labels" do
      @tag1.<=>(@tag2).should be_false
      @tag1.<=>(@tag1).should be_true
    end
  end
end
