# @abstract Handles tag management
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_TAG_ID = "$Id: tag.rb,v 2d42c3830ab0 2012/09/07 13:56:17 roberto $"

# Handles GMail tags
#
class Tag
  # Handles a tag
  #
  # Used when creating a mailbox based on the tag itself, after replacing the "/" used
  # by IMAP by "-"
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
end # -- Tag
