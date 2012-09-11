# @abstract GMail-specific specs
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: gmvault_spec.rb,v f58a56341c42 2012/09/11 23:50:06 roberto $

require "rspec"
require "mail"
require "json"
require "gmail/gmvault"

describe GMail do

  before(:all) do
    @tag = "Perso/Foo"
    @goodmail = GMail.new(File.expand_path(File.dirname(__FILE__) + '/../test/good.meta'))
    @badmail = GMail.new(File.expand_path(File.dirname(__FILE__) + '/../test/bad.meta'))
  end

  describe "#initialize" do
    it "should raise an exception if no parameter is given" do
      expect{GMail.new}.to RaiseError(ArgumentError)
    end

    it "should raise an exception if filename does not end with .eml" do
      expect{GMail.new("foo.bar")}.to RaiseError(ArgumentError)
    end

    it "should raise an exception if file does not exist" do
      expect{GMail.new("/nonexistent")}.to RaiseError(ArgumentError)
    end

    it "should have the necessary attributes" do
      @goodmail.name.should be_an_instance_of(String)
      @goodmail.meta.should be_an_instance_of(NilClass)
      @goodmail.mail.should be_an_instance_of(Mail)
      @goodmail.tags.should be_an_instance_of(Array)
      @goodmail.tags.should == []
    end
  end

  describe "#load" do
    it "should return the mail if tag is nil" do
      @goodmail.load(nil).should_not be_nil
      @badmail.load(nil).should_not be_nil
    end

    it "should return the mail if tag is nil" do
      @goodmail.load(nil).should_not be_nil
      @badmail.load(nil).should_not be_nil
    end

    it "should return a gm_id for a matching mail" do
      @goodmail.load(tag).should_not be_nil
    end

    it "should return nil for a non-matching mail" do
      @badmail.load(tag).should be_nil
    end
  end

  describe "#save" do
    it "should save the mail in the given maildir mailbox"
  end

  describe "#match" do
    it "should return false if mail does not have the tag" do
      @badmail.match(@tag).should be_false
    end

    it "should return true if mail has the tag" do
      @goodmail.match(@tag).should be_true
    end
  end

  describe "#meta_path" do
    it "should give you back a .meta filename" do
      File.basename(@badmail.meta_path).should eq("bad.meta")
      File.basename(@goodmail.meta_path).should eq("good.meta")
    end
  end

  describe "#mail_path" do
    it "should give you back a .eml filename" do
      File.basename(@badmail.mail_path).should eq("bad.eml")
      File.basename(@goodmail.mail_path).should eq("good.eml")
    end
  end
end
