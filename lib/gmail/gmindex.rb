# @abstract Manages an index of message-id in a given Maildir mailbox
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMI_ID = "$Id: gmindex.rb,v c1c73d6b8671 2012/09/23 21:24:55 roberto $"

require "rufus/tokyo"

# Manages a database of message-ids from mail converted from gmvault into Maildir
#
class GmIndex
  attr_reader :path, :db

  # Create a new index if the file is not present or open the current one.
  # @param [String] path path to the mailbox in Maildir format
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
    return false if gm_id.nil?
    return false if @db[gm_id].nil?
    true
  end

  # Allow getting a value
  # @param gm_id GMail ID of the message
  # @return [TrueClass|FalseClass] whether it has been stored
  def [](gm_id)
    if gm_id.nil?
      return(gm_id)
    end
    @db[gm_id]
  end

  # Allow inserting a new value
  # @param gm_id GMail ID of the message
  # @param value Value to assign
  def []=(gm_id, value)
    return nil if gm_id.nil?
    @db[gm_id] = value
  end

  # Return the last_id from the db
  # @return [String] +last_id'+property from the db
  def last_id
    @db["last_id"]
  end

  # Set the last_id property in the db
  # @param [Fixnum] value set the +last_id+ property to +value+
  def last_id=(value)
    @db["last_id"] = value
  end
end
