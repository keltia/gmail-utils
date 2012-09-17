# @abstract Handles tag management
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_TAG_ID = "$Id: tag.rb,v 56b33329c4e5 2012/09/17 23:58:18 roberto $"

# Handles GMail tags
#
class Tag
  # Handles a tag
  #
  # Used when creating a mailbox based on the tag itself, after replacing the "/" used
  # by IMAP by "-"
  #
  # label tag's name
  attr_accessor :label

  # @param [String] label name of the tag
  # @return [Tag] the newly created tag
  def initialize(label)
    @label = label
  end

  # Generate a FS-compatible label
  # @return [String] the converted label
  def normalize
    return @label.gsub(%r{/}, '-')
  end
  
  # Match the tag against another one, string/array
  # @param tags string or array representing a tag or list thereof
  # @return [True|False] rematching result
  def match(tags)
    t = tags.dup
    if tags.class == String
      t = [ tags ]
    end
    flag = false
    t.each{|e| flag = @label == e ? true : false }
    flag
  end
end # -- Tag
