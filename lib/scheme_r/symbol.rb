# coding: utf-8
class SchemeR
class Symbol
  @instances = {}

  class <<self
    def new_with_recycle(value)
      @instances[value.to_s.to_sym] ||= new_without_recycle(value)
    end
    alias_method :new_without_recycle, :new
    alias_method :new, :new_with_recycle
  end

  def initialize(value)
    @value = value.to_s.to_sym
  end

  def inspect
    @value.inspect
  end

  def to_s
    @value.to_s
  end

  def ==(other)
    other.is_a?(self.class) &&
      @value == other.instance_variable_get(:@value)
  end
  alias_method :eql?, :==

  def ===(other)
    other.is_a?(self.class)
  end
end
end
