# @abstract Manages an index of message-id in a given Maildir mailbox
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMI_ID = "$Id: gmindex.rb,v c7d70eb97799 2012/09/18 09:08:46 roberto $"

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

  # Check if a given gm_id is present
  # @param gm_id GMail ID of the message
  # @return [TrueClass|FalseClass] true if present
  def present?(gm_id)
    return false if @db[gm_id].nil?
    true
  end

  # Allow getting a value
  # @param gm_id GMail ID of the message
  # @return [TrueClass|FalseClass] whether it has been stored
  def [](gm_id)
    @db[gm_id]
  end

  # Allow inserting a new value
  # @param gm_id GMail ID of the message
  #
  def []=(gm_id, value)
    @db[gm_id] = value
  end

end
