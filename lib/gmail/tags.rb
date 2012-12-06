# tags.rb
#
# @author Ollivier Robert <roberto@keltia.net> 
#
# $Id: tags.rb,v 1b72cc5227d7 2012/12/06 14:04:39 roberto $

require "gmail/tag"

module GMail
# Represent a bag of tags backed by a TC db
  class TagList
    include Enumerable

    attr_accessor :list

    # Constructor
    def initialize
      @list = Hash.new{0}
    end

    # iterator
    def each
      @list.each_key{|e| yield e}
    end

    # []
    # @param [GMail::Tag] k tag to get the counter of
    # @return [Fixnum] counter
    def [](k)
      @list[k]
    end

    # []=
    # @param [GMail::Tag] k tag to get the counter of
    # @param [Fixnum] v value to set the counter to
    # @return [Fixnum] counter
    def []=(k, v)
      @list[k] = v
    end

    # <<
    # @param [GMail::Tag] e new tag to insert
    def <<(e)
      if e.class == GMail::Tag
        @list[e] += 1
      else
        @list[GMail::Tag.new(e)] += 1
      end
      self
    end

    # add
    # @param [GMail::Tag] e new tag to insert
    def add(e)
      self.<<(e)
    end

    # include?
    # @param [GMail::Tag|String] elem check if elem is present in the list
    def include?(elem)
      @list.include?(elem)
    end

    # length
    # @return [Fixnum] list length
    def length
      @list.length
    end

    # keys
    # @return [Array] list of all keys
    def keys
      @list.keys
    end
  end # -- TagList
end # -- GMail

