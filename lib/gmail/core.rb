# $Id: core.rb,v 004b15a184a6 2012/10/18 21:45:32 roberto $
#
module GMail
  module Utils
    def self.install_directory
      @install_directory ||= File.expand_path(File.dirname(__FILE__))
    end

    def self.share_directory
      @data_directory ||= File.expand_path(File.join(Raw::Utils.install_directory, "/../../share/"))
    end
  end
end