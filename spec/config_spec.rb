# @abstract Configuration handling specs
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: config_spec.rb,v c9004a1aeb2a 2012/12/06 17:12:41 roberto $

require 'rspec'
require 'gmvault'

FAKE_ADDR='keltia+fake@gmail.com'
TEST_DIR='test/dot.gmvault'

describe GmVault::Config do
  attr_reader :list

  before(:all) do
    @cfg = GmVault::Config.new(TEST_DIR)
  end

  describe "#initialize" do
    it "should not be nil" do
      @cfg.should_not be_nil
    end

    it "should create a Config object" do
      @cfg.should be_an_instance_of(GmVault::Config)
    end

    it 'should set the right members' do
      @cfg.path.should eq(TEST_DIR)
    end
  end

  describe "#list" do
    it "should return an Array object" do
      @cfg.list.should be_an_instance_of(Array)
    end

    it 'should get all the configured addresses' do
      @cfg.list.should eq([FAKE_ADDR])
    end
  end

  describe ".list" do
    it "should return an Array object" do
      GmVault::Config.list(TEST_DIR).should be_an_instance_of(Array)
    end

    it "should get all the configured addresses" do
      GmVault::Config.list(TEST_DIR).should eq([FAKE_ADDR])
    end
  end

  describe ".recent" do
    it "should get the most recent used address"
  end
end