# @abstract GmIndex-specific specs
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: gmindex_spec.rb,v fceaf6eb2d38 2012/09/13 16:07:40 roberto $

require "rspec"
require "mail"
require "gmail/gmvault"
require "gmail/gmindex"

describe GmIndex do

  before(:all) do
    @ind = GmIndex.new(File.expand_path(File.dirname(__FILE__) + '/../test/Perso-Foo'))
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
    it "should save the given message-id in the db"
  end

  describe "#present?" do
    it "should check whether a given message-id is present"
  end
  
end