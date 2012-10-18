# $Id: core.rb,v 5a113e62ab59 2012/10/18 21:53:44 roberto $
#
module GMail
  module Utils
    def self.install_directory
      @install_directory ||= File.expand_path(File.dirname(__FILE__))
    end

    def self.share_directory
      @share_directory ||= File.expand_path(File.join(GMail::Utils.install_directory, "/../../share/"))
    end
  end
end