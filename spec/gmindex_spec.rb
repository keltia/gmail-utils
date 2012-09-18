# @abstract GmIndex-specific specs
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: gmindex_spec.rb,v 4cbb5180fbdc 2012/09/18 09:08:21 roberto $

require "rspec"
require "mail"
require "maildir"
require "gmail/gmvault"
require "gmail/gmindex"

describe GmIndex do

  before(:all) do
    @md = Maildir.new(File.expand_path(File.dirname(__FILE__) + '/../test/Perso-Foo'))
    @ind = GmIndex.new(File.expand_path(File.dirname(__FILE__) + '/../test/Perso-Foo'))
    @mail = GMail.new(File.expand_path(File.dirname(__FILE__) + '/../test/1412679471642059988.meta'))
  end

  describe "#initialize" do
    it "should have the required attributes" do
      @ind.path.should be_an_instance_of(String)
      @ind.db.should be_an_instance_of(Rufus::Tokyo::Cabinet)
      @ind.path.should_not be_nil
      @ind.path.should_not eq("")
      @ind.db.should_not be_nil
    end
  end

  describe "#save" do
    it "should save the given message-id in the db" do
      @ind[@mail.mail["gm_id"]] = true
      @ind[@mail.mail["gm_id"]].should_not be_nil
      @ind.db[@mail.mail["gm_id"]].should_not be_nil
    end
  end

  describe "#present?" do
    it "should return false if not present" do
      @ind.present?("foo-bar-baz").should be_false
      @ind[@mail.mail["gm_id"]] = true
      @ind.present?(@mail.mail["gm_id"]).should be_true
    end
  end
  
end