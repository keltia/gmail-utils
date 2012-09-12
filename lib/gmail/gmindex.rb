# @abstract Manages an index of message-id in a given Maildir mailbox
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMI_ID = "$Id: gmindex.rb,v f3a4da3ed2d3 2012/09/12 14:13:00 roberto $"

require "rufus/tokyo"

# Manages a database of message-id from mail converted from gmvault into Maildir
#
class GmIndex
  attr_reader :path

  def initialize(path)
    if File.exists?("#{path}/cur") and File.exists?("#{path}/new")
      @path = path
    else
      raise ArgumentError, "#{path} is not a Maildir mailbox"
    end
    if File.exists?("#{path}/index.tch")
      @db = Rufus::Tokyo::Cabinet.new("#{path}/index.tch")
    end
  end
end
