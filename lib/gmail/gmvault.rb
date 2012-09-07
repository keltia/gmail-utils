# @abstract Handles GmVault directory structure and mails/metadata
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMV_ID = "$Id: gmvault.rb,v aa332f92562c 2012/09/07 15:34:39 roberto $"

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
  def load(tag = nil)
    File.open(self.meta_path) do |fh|
      @meta = JSON.load(fh)
    end

    # check consistency
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

  # @return[String] returns the full filename to the mail itself
  def mail_path
    @path + ".eml"
  end

  # @return[String] returns full filename of the metadata
  def meta_path
    @path + ".meta"
  end
end # -- GMail

