# @abstract Find the default account in GMVault config
#
# @author Ollivier Robert <roberto@keltia.net>
#
# XXX Assume we use OAuth for all accounts

VCS_CFG_ID = '$Id: config.rb,v c4e297bd63db 2012/12/06 15:07:09 roberto $'

# Non-standard packages
#
require 'json'


# Define our configuration class
#
module GmVault
  # Wrapper around GmVault configuration
  class Config
    attr_reader :path

    # Default location
    BASE_DIR = ENV['HOME'] + '/.gmvault'
    # Default maildb location
    DEF_DB = ENV['HOME'] + '/Mail/gmvault-db'

    # Constructor
    # @param [String] path path to the base directory for configuration
    def initialize(path = BASE_DIR)
      @path = path
    end

    # Looks at all configured email addresses
    # @return [Array] list of different email addresses
    def find_addrs
      @list = Array.new
      Dir.chdir(@path) do
        Dir['**.oauth'].each do |m|
          @list << m.split('.')[0..-2].join('.')
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
    def self.list(path = BASE_DIR)
      self.new(path).list
    end
  end # -- Config
end
