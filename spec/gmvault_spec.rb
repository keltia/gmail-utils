# @abstract GMail-specific specs
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: gmvault_spec.rb,v c1ba0f25214f 2012/09/18 15:54:10 roberto $

require "rspec"
require "mail"
require "json"
require "gmail/gmvault"

ID_LIST = {
    "@goodmail" => "1412679471642059988",
    "@badmail"  => "1412714559964509103",
    "@empty"    => "1412274560099820953",
}

describe GMail do

  before(:all) do
    @tag = "Perso/Foo"
    ID_LIST.each_pair do |k, v|
      eval("#{k} = GMail.new(File.expand_path(File.dirname(__FILE__) + '/test/#{v}.meta'))")
    end

    # load meta for testing
    ID_LIST.each_pair do |k, v|
      File.open(File.expand_path(File.dirname(__FILE__) + "/../test/#{v}.meta")) do |fh|
        eval("#{k}_m = JSON.load(fh)")
      end
    end
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
      @goodmail.tags.should be_an_instance_of(Array)
      @goodmail.meta.should_not be_nil
      @goodmail.meta.should be_an_instance_of(Hash)
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

  describe "#mail" do
    it "should return the mail content" do
      @goodmail.mail.should be_instance_of(Mail::Message)
      @badmail.mail.should be_instance_of(Mail::Message)
      @empty.mail.should be_instance_of(Mail::Message)
    end

    it 'should have the right types' do
      @goodmail.mail.header.should be_an_instance_of(Mail::Header)
      @badmail.mail.header.should be_an_instance_of(Mail::Header)
      @empty.mail.header.should be_an_instance_of(Mail::Header)
    end

    it "should have a Lines: header entry" do
      @goodmail.mail['Lines'].should_not be_nil
      @badmail.mail['Lines'].should_not be_nil
      @empty.mail['Lines'].should_not be_nil
    end

    it "should have a Lines: header entry with the right type" do
      @goodmail.mail['Lines'].should be_an_instance_of(Mail::Field)
      @badmail.mail['Lines'].should be_an_instance_of(Mail::Field)
      @empty.mail['Lines'].should be_an_instance_of(Mail::Field)
    end

    it "should have the right number of lines" do
      @goodmail.mail.header['Lines'].to_s.should eq("1")
      @badmail.mail.header['Lines'].to_s.should eq("35")
      @empty.mail.header['Lines'].to_s.should eq ("58")
    end
  end

  describe "#gm_id" do
    it "should return the GMail ID of the mail" do
      @goodmail.gm_id.should eq(@goodmail_m["gm_id"].to_s)
      @badmail.gm_id.should eq(@badmail_m["gm_id"].to_s)
      @empty.gm_id.should eq(@empty_m["gm_id"].to_s)
    end
  end

  describe "#thread_ids" do
    it "should return the thread IDs of the conversation" do
      @goodmail.thread_ids.should eq(@goodmail_m["thread_ids"].to_s)
      @badmail.thread_ids.should eq(@badmail_m["thread_ids"].to_s)
      @empty.thread_ids.should eq(@empty_m["thread_ids"].to_s)
    end
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
