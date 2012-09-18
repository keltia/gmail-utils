# @abstract GmIndex-specific specs
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: gmindex_spec.rb,v c76853b5a5b0 2012/09/18 15:50:12 roberto $

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
      @mail.gm_id.should_not be_nil
      @ind[@mail.gm_id] = true
      @ind[@mail.gm_id].should_not be_nil
      @ind.db[@mail.gm_id].should_not be_nil
    end
  end

  describe "#present?" do
    it "should return nothing with nil" do
      @ind.present?(nil).should be_false
    end

    it "should return false if not present" do
      @ind.present?("foo-bar-baz").should be_false
    end

    it "should return true if present" do
      @ind[@mail.gm_id] = true
      @ind.present?(@mail.gm_id).should be_true
    end
  end
  
end