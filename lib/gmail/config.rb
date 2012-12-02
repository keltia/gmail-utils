# @abstract Find the default account in GMVault config
#
# @author Ollivier Robert <roberto@keltia.net>
#
# XXX Assume we use OAuth for all accounts

VCS_CFG_ID = "$Id: config.rb,v ab6b367be5cf 2012/12/02 18:16:34 roberto $"

# Non-standard packages
#
require "json"


# Define our configuration class
#
module GMail
  class Config
    attr_reader :path

    # Default location
    BASE_DIR = ENV["HOME"] + "/.gmvault"

    def initialize(path = BASE_DIR)
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
