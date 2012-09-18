# @abstract Manages an index of message-id in a given Maildir mailbox
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMI_ID = "$Id: gmindex.rb,v 9cb95816af03 2012/09/18 09:07:18 roberto $"

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
  # @return [TrueClass|FalseClass] true if present
  def present?(gm_id)
    false if @db[gm_id].nil?
    true
  end
end
