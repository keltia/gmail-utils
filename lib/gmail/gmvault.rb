# @abstract Handles GmVault directory structure and mails/metadata
#
# @author Ollivier Robert <roberto@keltia.net>

VCS_GMV_ID = "$Id: gmvault.rb,v e3e84bf9e104 2012/09/18 16:10:14 roberto $"

# Non-standard packages
#
require "json"

# Handle GmVault mails with .eml as raw mail and .meta as metadata (i.e.tags)
#
class GMail
  attr_reader :name
  attr_reader :meta
  attr_reader :tags

  # @param filename name of the file to open
  def initialize(filename)
    @path, ext = filename.split(/\./)
    raise(ArgumentError, "File should end in .meta: #{filename}") if ext != "meta"
    raise(ArgumentError, "File does not exist #{filename}") if not File.exists?(filename)
    @name = File.basename(@path)
    @mail = nil
    @tags = []
    self.load
  end # -- initialize

  # Preload metadata
  # @return [String] returns the mail id
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

  # @return [Mail::Message] returns the mail content
  def mail
    if @mail.nil?
      @mail = Mail.read(self.mail_path)
      lines = @mail.body.raw_source.split(%r{\r\n}).size
      @mail['Lines'] = lines.to_s
    end
    @mail
  end

  # Return the GMail ID
  # @@return [String] gm_id
  def gm_id
    @meta["gm_id"].to_s
  end

  # Return the GMail thread IDs
  # @@return [String] thread_ids
  def thread_ids
    @meta["thread_ids"].to_s
  end

  # @return [String] returns the full filename to the mail itself
  def mail_path
    @path + ".eml"
  end

  # @return [String] returns full filename of the metadata
  def meta_path
    @path + ".meta"
  end
end # -- GMail

