# coding: utf-8

#
#   [:cond, 
#     [[:>, :x, 3], 3],
#     [[:>, :x, 2], 2], 
#     [[:>, :x, 1], 1], 
#     [:else, 0]]
#
class SchemeR
module Cond
  def cond?(exp)
    exp[0] == :cond
  end
  def eval_cond(exp, env)
    eval_if(cond_to_if(cdr(exp)), env)
  end
  def cond_to_if(cond_exp)
    if null?(cond_exp)
      ""
    else
      e = car(cond_exp)
      cond, true_clause = e[0], e[1]
      cond = :true if cond == :else
      [:if, cond, true_clause, cond_to_if(cdr(cond_exp))]
    end
  end
end
end
