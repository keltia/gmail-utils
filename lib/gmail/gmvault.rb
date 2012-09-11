# @abstract Handles GmVault directory structure and mails/metadata
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMV_ID = "$Id: gmvault.rb,v ea0a61596c05 2012/09/11 20:24:00 roberto $"

# Handle GmVault mails with .eml as raw mail and .meta as metadata (i.e.tags)
#
class GMail
  attr_reader :name
  attr_reader :meta
  attr_reader :mail
  attr_reader :tags

  def initialize(filename)
    @path, ext = filename.split(/\./)
    raise ArgumentError if ext != "meta"
    raise ArgumentError if not File.exists?(filename)
    @name = File.basename(@path)
    @mail = Mail.new
    @meta = nil
    @tags = []
  end # -- initialize

  # @param tag the tag we want to filter on
  # @return[String] returns the mail id
  def load(tag = nil)
    File.open(self.meta_path) do |fh|
      @meta = JSON.load(fh)
    end

    # check consistency
    raise DataError if @meta.nil?
    if @name.to_i != @meta["gm_id"] then
      $stderr.puts(@meta)
      raise DataError, "Error: Internal inconsistency on #{@name} vs #{@meta['gm_id']}"
    end

    # Remove "internal tags"
    @tags = @meta['labels']
    @tags.delete_if{|e| e =~ /^\\/ }
    puts(@tags)
    if @tags.include?(tag) or @tags == tag
      @mail = Mail.read(self.mail_path)
      if $debug
        if @meta['msg_id'] != @mail.message_id then
          $stderr.puts("Warning: Internal inconsistency on #{@mail.message_id} vs #{@meta['msg_id']}")
        end
      end
      return(@meta["gm_id"])
    else
      return(nil)
    end
  end

  # @param tag match the mail to a given tag
  # @return[Comparable] say whether it has the given tag or not
  def match(tag)

  end

  # @param maildir save the mail in the given mailbox
  # @return[Comparable] say whether it has been saved
  def save(maildir)

  end

  # @return[String] returns the full filename to the mail itself
  def mail_path
    @path + ".eml"
  end

  # @return[String] returns full filename of the metadata
  def meta_path
    @path + ".meta"
  end
end # -- GMail

