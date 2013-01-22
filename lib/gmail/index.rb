# @abstract Manages an index of message-id in a given Maildir mailbox
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMI_ID = '$Id: index.rb,v 53c04364fd11 2013/01/22 22:50:03 roberto $'

require 'rufus/tokyo'
require 'gmail/version'

# Main namespace
module GMail
  # Manages a database of message-ids from mail converted from gmvault into Maildir
    class Index
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
      check_db()
    end

    # Check db version and upgrade it if needed
    def check_db
      if @db['db_version'].nil?
          @db['db_version'] = GMail::Utils::DB_VERSION
      end
      if @db['gmdb'].nil?
        puts('Warning: gmdb not found...')
      end
      if @db['db_version'] == '2'
        @db['last_sync'] = Time.now
        @db['db_version'] = '3'
      end
    end

    # Check if a given gm_id is present
    # @param gm_id GMail ID of the message
    # @return [TrueClass|FalseClass] true if present
    def present?(gm_id)
      return false if gm_id.nil?
      return @db.keys.include?(gm_id)
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
      @db['last_id']
    end

    # Set the last_id property in the db
    # @param [Fixnum] value set the +last_id+ property to +value+
    def last_id=(value)
      @db['last_id'] = value
    end

    # Return the time of the last sync through the 'last_sync' property
    # @return [Time] +last_sync+ property from the db
    def last_sync
      @db['last_sync']
    end

    # Set the last_sync property in the db
    # @param [Fixnum] value set the +last_id+ property to +value+
    def last_sync=(value)
      @db['last_sync'] = value
    end

    # Returns the size of the db
    # @return [Fixnum] size of the db
    def size
      @db.size
    end

    # Returns the path to the gmvault db
    # @return [String] path to gmvault db
    def gmdb
      @db['gmdb']
    end

    # Set the gmvault db path in the index
    # @param [String] value path to the gmvault db
    def gmdb=(value)
      @db['gmdb'] = value || ''
    end

    # Returns the db version
    # @return [Fixnum] version number
    def version
      @db['db_version'].to_i || 0
    end
  end
end
