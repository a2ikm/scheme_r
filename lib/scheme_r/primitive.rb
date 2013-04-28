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
    :<= => [:prim, lambda { |x, y| x <= y }], 
    :<  => [:prim, lambda { |x, y| x <  y }], 
  }
  def primitive?(exp)
    exp[0] == :prim
  end
  def apply_primitive(fun, args)
    # consといったメソッドはインスタンスメソッドとして定義されているので、
    # ブロックはインスタンスのスコープで評価しなければならない
    instance_exec(*args, &fun[1])
  end
end
end
