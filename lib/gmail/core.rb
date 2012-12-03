# $Id: core.rb,v 1900df32c210 2012/12/03 22:28:26 roberto $
#
module GMail
  module Utils
    # Returns the installation directory
    # @return [String] path to installation
    def self.install_directory
      @install_directory ||= File.expand_path(File.dirname(__FILE__))
    end

    # Returns the path to the share/ directory in the gem
    # @return [String] path to share/
    def self.share_directory
      @share_directory ||= File.expand_path(File.join(GMail::Utils.install_directory, "/../../share/"))
    end
  end
end