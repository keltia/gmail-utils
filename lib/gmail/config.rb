# @abstract Find the default account in GMVault config
#
# @author Ollivier Robert <roberto@keltia.net>
#
# XXX Assume we use OAuth for all accounts

VCS_CFG_ID = "$Id: config.rb,v 341f2ce15d43 2012/10/22 23:11:01 roberto $"

# Non-standard packages
#
require "json"

# Default location
BASE_DIR = ENV["HOME"] + "/.gmvault"

# Define our configuration class
#
module GMail
  class Config
    attr_reader :path

    def initialize(path = "#{ENV["HOME"] + "/.gmvault"}")
      @path = path
    end

    def find_addrs
      @list = Array.new
      Dir.chdir(@path) do
        Dir["**.oauth"].each do |m|
          @list << m.split(".")[0..-2].join(".")
        end
      end
      @list
    end

    def list
      @list || find_addrs()
    end

    def self.list(path)
      self.new(path).list
    end
  end # -- Config
end
