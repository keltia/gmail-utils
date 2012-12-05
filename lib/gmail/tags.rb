# tags.rb
#
# @author Ollivier Robert <roberto@keltia.net> 
#
# $Id: tags.rb,v 97488c700e02 2012/12/05 00:12:56 roberto $

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
      @list.each{|e| yield e}
    end

    # <<
    # @param [GMail::Tag] e new tag to insert
    def <<(e)
      if e.class == GMail::Tag
        @list[e] += 1
      else
        @list[GMail::Tag.new(e)] += 1
      end
    end

    # add
    # @param [GMail::Tag] e new tag to insert
    def add(e)
      self.<<(e)
    end

    # length
    # @return [Fixnum] list length
    def length
      @list.length
    end
  end # -- TagList
end # -- GMail

