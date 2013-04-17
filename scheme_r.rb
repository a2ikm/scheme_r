#!/usr/bin/env ruby
# coding: utf-8

class SchemeR
  def _eval(exp)
    if list?(exp)
      fun  = _eval(car(exp))
      args = eval_list(cdr(exp))
      apply(fun, args)
    else
      if immediate_value?(exp)
        exp
      else
        lookup_primitive_fun(exp)
      end
    end
  end
  PRIMITIVE_FUN = {
    :+ => lambda { |x, y| x + y }, 
    :- => lambda { |x, y| x - y }, 
    :* => lambda { |x, y| x * y }, 
    :/ => lambda { |x, y| x / y }, 
  }
  def lookup_primitive_fun(exp)
    PRIMITIVE_FUN[exp]
  end
  def eval_list(list)
    list.map { |exp| _eval(exp) }
  end
  def apply(fun, args)
    fun.call(*args)
  end
  def car(list)
    list[0]
  end
  def cdr(list)
    list[1..-1]
  end
  def immediate_value?(exp)
    numeric?(exp)
  end
  def numeric?(exp)
    exp.is_a?(Numeric)
  end
  def list?(exp)
    exp.is_a?(Array)
  end
end
