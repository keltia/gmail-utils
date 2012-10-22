# @abstract Configuration handling specs
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: config_spec.rb,v 341f2ce15d43 2012/10/22 23:11:01 roberto $

require "rspec"
require "gmail"

FAKE_ADDR="keltia+fake@gmail.com"
TEST_DIR="test/dot.gmvault"

describe GMail::Config do
  attr_reader :list

  before(:all) do
    @cfg = GMail::Config.new(TEST_DIR)
  end

  describe "#initialize" do
    it "should not be nil" do
      @cfg.should_not be_nil
    end

    it "should create a Config object" do
      @cfg.should be_an_instance_of(GMail::Config)
    end

    it "should set the right members" do
      @cfg.path.should eq(TEST_DIR)
    end
  end

  describe "#list" do
    it "should get all the configured addresses" do
      @cfg.list.should eq([FAKE_ADDR])
    end
  end

  describe ".list" do
    it "should get all the configured addresses" do
      GMail::Config.list(TEST_DIR).should eq([FAKE_ADDR])
    end
  end

  describe ".recent" do
    it "should get the most recent used address"
  end
end