# @abstract Handles GmVault directory structure and mails/metadata
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMV_ID = "$Id: gmvault.rb,v b0db47628bab 2012/09/07 12:25:04 roberto $"

# Handle GmVault mails with .eml as raw mail and .meta as metadata (i.e.tags)
#
class GMail
  attr_reader :name
  attr_reader :meta
  attr_reader :mail
  attr_reader :tags

  def initialize(filename)
    @path = filename.split(/\./)[0]
    @name = File.basename(@path)
    @mail = Mail.new
    @tags = []
  end # -- initialize

  # @return[String] returns the mail id
  def load
    File.open(self.meta_path) do |fh|
      @meta = JSON.load(fh)
    end

    # check consistency
    if @name.to_i != @meta["gm_id"] then
      $stderr.puts(@meta)
      raise DataError, "Error: Internal inconsistency on #{@name} vs #{@meta['gm_id']}"
    end

    # Remove "internal tags"
    @tags = @meta['labels'].delete_if {|e| e =~ /^\\\\/ }

    @mail = Mail.read(self.mail_path)
    if @meta['msg_id'] != @mail.message_id then
      raise DataError, "Error: Internal inconsistency on #{@mail.message_id} vs #{@meta['msg_id']}"
    end
    return(@meta["gm_id"])
  end

  # @return[String] returns the full filename to the mail itself
  def mail_path
    @path + ".eml"
  end

  # @return[String] returns full filename of the metadata
  def meta_path
    $stderr.puts(@name)
    @path + ".meta"
  end
end # -- GMail

