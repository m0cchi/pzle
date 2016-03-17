require_relative 'util/hash'
require_relative 'util/array'

module Pzle
  using ArrayMethod
  using HashMethod

  class Html
    def initialize(array)
      @tag_name = array[0]
      @attr = array[1]
      @text = array[2]
      if @text.nil? && !@attr.hash?
        @text = @attr
        @attr = nil
      end
      
      if @text.array? && !@text.tag?
        ret = []
        @text.each do |v|
          ret.push Html.new(v)
        end
        @text = ret
      elsif @text.array?
        @text = Html.new(@text)
      end
    end
    
    def has_attr?
      !@attr.nil? || !@attr.empty?
    end
    
    def attr
      return "" unless has_attr?
      ret = []
      @attr.each do |k,v|
        ret.push case v
                 when nil then " #{k.to_s}"
                 else " #{k.to_s}=\"#{v.to_s}\""
                 end
      end
      ret.join('')
    end

    def text
      unless @text.tag?
        @text.to_s
      else
        ret = []
        @text.each do|v|
          ret.push v.to_s
        end
        ret.join('')
      end
    end
    
    def to_s
      ret = ["<#{@tag_name.to_s}#{attr}>"]
      ret.push "#{text}</#{@tag_name}>" unless @text.nil?
      ret.join('')
    end
  end
end
