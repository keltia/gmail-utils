# @abstract Handles GMail tag management
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_TAG_ID = "$Id: tag.rb,v 312efb7675ea 2012/09/23 20:25:55 roberto $"

# Handles GMail tags
#
# Used when creating a mailbox based on the tag itself, after replacing the +"/"+ used
# by GMail by +"-"+
#
class Tag
  # label tag's name
  attr_reader :label

  # Create a new tag from the parameter
  #   Tag.new("the/tag") # => a new tag
  def initialize(label)
    @label = label
  end

  # Generate a FS-compatible label
  # If +@label+ is "Foo/Bar"
  #   self.normalize # => "Foo-Bar"
  #
  # @return [String] the converted label
  def normalize
    return @label.gsub(%r{/}, '-')
  end
  
  # Match the tag against another one or multiple values
  # If +@label+ is +"Bar"+ then
  #   self.match("Bar") # => true
  #   self.match(["Foo", "Bar"]) # => true
  #   self.match(["tag1", "tag2"]) # => false
  #
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
