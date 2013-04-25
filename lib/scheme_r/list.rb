# coding: utf-8

class SchemeR
module List
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
end
end