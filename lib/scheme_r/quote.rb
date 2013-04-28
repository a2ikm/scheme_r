# coding: utf-8
#
#   [:quote, [1, 2, 3]]  #=> [1, 2, 3]
#   [:quote, [:+, 1, 2]] #=> [:+, 1, 2]
#
class SchemeR
module Quote
  def quote?(exp)
    exp[0] == :quote
  end
  def eval_quote(exp, env)
    car(cdr(exp))
  end
end
end
