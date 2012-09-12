# @abstract GMail-specific specs
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: gmvault_spec.rb,v 08f531278443 2012/09/12 10:30:40 roberto $

require "rspec"
require "mail"
require "json"
require "gmail/gmvault"

describe GMail do

  before(:all) do
    @tag = "Perso/Foo"
    @goodmail = GMail.new(File.expand_path(File.dirname(__FILE__) + '/../test/1412679471642059988.meta'))
    @badmail = GMail.new(File.expand_path(File.dirname(__FILE__) + '/../test/1412714559964509103.meta'))
    @empty = GMail.new(File.expand_path(File.dirname(__FILE__) + '/../test/1412714559964509103.meta'))
  end

  describe "#initialize" do
    it "should raise an exception if no parameter is given" do
      expect{GMail.new}.to raise_exception(ArgumentError)
    end

    it "should raise an exception if filename does not end with .eml" do
      expect{GMail.new("foo.bar")}.to raise_exception(ArgumentError)
    end

    it "should raise an exception if file does not exist" do
      expect{GMail.new("/nonexistent")}.to raise_exception(ArgumentError)
    end

    it "should have the necessary attributes" do
      @goodmail.name.should be_an_instance_of(String)
      @goodmail.mail.should be_an_instance_of(NilClass)
      @goodmail.tags.should be_an_instance_of(Array)
      @goodmail.meta.should_not be_nil
    end
  end

  describe "#load" do
    it "should load all metadata" do
      @goodmail.load.should_not be_nil
      @badmail.load.should_not be_nil
    end

    it "should have consistent metadata" do
      @goodmail.name.to_i.should == @goodmail.meta["gm_id"]
      @badmail.name.to_i.should == @badmail.meta["gm_id"]
    end

    it "can have an empty set of tags" do
      @empty.tags.should == []
    end
    
    it "should remove all internal tags" do
      clean = @goodmail.tags.map{|e| e =~ /\\(.*?)/}.compact
      clean.should == []
      clean = @badmail.tags.map{|e| e =~ /\\(.*?)/}.compact
      clean.should == []
    end
  end

  describe "#save" do
    it "should save the mail in the given maildir mailbox"
  end

  describe "#meta_path" do
    it "should give you back a .meta filename" do
      File.basename(@badmail.meta_path).should eq("1412714559964509103.meta")
      File.basename(@goodmail.meta_path).should eq("1412679471642059988.meta")
    end
  end

  describe "#mail_path" do
    it "should give you back a .eml filename" do
      File.basename(@badmail.mail_path).should eq("1412714559964509103.eml")
      File.basename(@goodmail.mail_path).should eq("1412679471642059988.eml")
    end
  end
end
