# coding: utf-8

class SchemeR
module Primitive
  FUNCTIONS = {
    :+ => [:prim, lambda { |x, y| x + y }],  
    :- => [:prim, lambda { |x, y| x - y }],
    :* => [:prim, lambda { |x, y| x * y }],
    :/ => [:prim, lambda { |x, y| x / y }],
    
    :>  => [:prim, lambda { |x, y| x >  y }], 
    :>= => [:prim, lambda { |x, y| x >= y }], 
    :== => [:prim, lambda { |x, y| x == y }], 
    :<= => [:prim, lambda { |x, y| y <= y }], 
    :<  => [:prim, lambda { |x, y| y <  y }], 
  }
  def primitive?(exp)
    exp[0] == :prim
  end
  def apply_primitive(fun, args)
    fun[1].call(*args)
  end
end
end
