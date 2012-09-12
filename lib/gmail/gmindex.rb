# @abstract Manages an index of message-id in a given Maildir mailbox
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMI_ID = "$Id: gmindex.rb,v 39ec4d02a7a0 2012/09/12 13:54:49 roberto $"

require "rufus/tokyo"

# Manages a database of message-id from mail converted from gmvault into Maildir
#
class GmIndex
  attr_reader :path
end