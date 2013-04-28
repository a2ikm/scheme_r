# coding: utf-8

class SchemeR
module List
  FUNCTIONS = {
    nil:    [], 
    null?:  [:prim, lambda { |list| null?(list) }], 
    cons:   [:prim, lambda { |a, b| cons(a, b) }], 
    car:    [:prim, lambda { |list| car(list) }], 
    cdr:    [:prim, lambda { |list| cdr(list) }], 
    list:   [:prim, lambda { |*args| list(*args) }]
  }
  def list?(exp)
    exp.is_a?(Array)
  end
  def eval_list(list, env)
    list.map { |exp| _eval(exp, env) }
  end
  def car(list)
    list[0]
  end
  def cdr(list)
    list[1..-1]
  end
  def null?(list)
    list.empty?
  end
  def cons(a, b)
    if list?(b)
      [a] + b
    else
      raise TypeError
    end
  end
  def list(*args)
    args
  end
end
end
