# @abstract Manages an index of message-id in a given Maildir mailbox
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMI_ID = "$Id: gmindex.rb,v 1a60f17647f7 2012/09/17 16:14:19 roberto $"

require "rufus/tokyo"

# Manages a database of message-id from mail converted from gmvault into Maildir
#
class GmIndex
  attr_reader :path, :db

  def initialize(path)
    if File.exists?("#{path}/cur") and File.exists?("#{path}/new")
      @path = path
    else
      raise ArgumentError, "#{path} is not a Maildir mailbox"
    end
    @db = Rufus::Tokyo::Cabinet.new("#{path}/index.tch")
  end

  # @param gm_id GMail ID of the message
  # @return[Comaprable] true if present
  def present?(gm_id)
    false if @db[gm_id].nil?
    true
  end
end
