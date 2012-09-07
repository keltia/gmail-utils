# @abstract Handles tag management
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_TAG_ID = "$Id: tag.rb,v b0db47628bab 2012/09/07 12:25:04 roberto $"

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
    raise DataError if label.nil?

    @label = label
  end

  # Generate a FS-compatible label
  # @return [String] the converted label
  def normalize
    return @label.gsub(%r{/}, '-')
  end
end # -- Tag
