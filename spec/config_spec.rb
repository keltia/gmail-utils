# @abstract Configuration handling specs
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: config_spec.rb,v d710b2d69339 2012/10/22 15:14:52 roberto $

require "rspec"
require "gmail"

describe GMail::Config do
  attr_reader :list

  describe "#initialize" do
    it "should create a Config object"
  end

  describe ".list" do
    it "should get the default address"
  end

  describe ".recent" do
    it "should get the most recent used address"
  end
end