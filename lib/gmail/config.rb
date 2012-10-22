# @abstract Find the default account in GMVault config
#
# @author Ollivier Robert <roberto@keltia.net>
#
# XXX Assume we use OAuth for all accounts

VCS_CFG_ID = "$Id: config.rb,v d710b2d69339 2012/10/22 15:14:52 roberto $"

# Non-standard packages
#
require "json"

# Default location
BASE_DIR = ENV["HOME"] + "/.gmvault"

# Define our configuration class
#
module GMail
  class Config

  end # -- Config
end
