# @abstract Handles GmVault directory structure and mails/metadata
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMV_ID = "$Id: gmvault.rb,v 6fa9a848f56d 2012/09/17 15:42:03 roberto $"

# Handle GmVault mails with .eml as raw mail and .meta as metadata (i.e.tags)
#
class GMail
  attr_reader :name
  attr_reader :meta
  attr_reader :tags

  def initialize(filename)
    @path, ext = filename.split(/\./)
    raise ArgumentError if ext != "meta"
    raise ArgumentError if not File.exists?(filename)
    @name = File.basename(@path)
    @mail = nil
    @tags = []
    self.load
  end # -- initialize

  # Preload metadata
  # @return[String] returns the mail id
  def load
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
    @tags = @meta['labels'].delete_if{|e| e =~ /^\\/ }
    @meta["gm_id"]
  end

  # @return[Mail::Message] returns the mail content
  def mail
    if @mail.nil?
      @mail = Mail.read(self.mail_path)
      if @meta['msg_id'] != @mail.message_id then
        $stderr.puts("Warning: Internal inconsistency on #{@mail.message_id} vs #{@meta['msg_id']}")
      end
      lines = @mail.body.raw_source.split(%r{\r\n}).size
      @mail['Lines'] = lines.to_s
    end
    @mail
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

