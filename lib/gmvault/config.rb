# @abstract Find the default account in GMVault config
#
# @author Ollivier Robert <roberto@keltia.net>
#
# XXX Assume we use OAuth for all accounts

VCS_CFG_ID = "$Id$"

# Non-standard packages
#
require "json"


# Define our configuration class
#
module GmVault
  class Config
    attr_reader :path

    # Default location
    BASE_DIR = ENV["HOME"] + "/.gmvault"

    def initialize(path = BASE_DIR)
      @path = path
    end

    # Looks at all configured email addresses
    # @return [Array] list of different email addresses
    def find_addrs
      @list = Array.new
      Dir.chdir(@path) do
        Dir["**.oauth"].each do |m|
          @list << m.split(".")[0..-2].join(".")
        end
      end
      @list
    end

    # Get all configured email addresses
    # @return [Array] list of different email addresses
    def list
      @list || find_addrs()
    end

    # Class method equiv. to #list
    # @return [Array] list of different email addresses
    def self.list(path)
      self.new(path).list
    end
  end # -- Config
end
