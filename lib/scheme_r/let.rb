# coding: utf-8

# let returns some value(s) with given environment and function.
# 
#   [:let, [[:x, 1], [:y, 2]], function]
# 
# is just same as:
#
#   [[:lambda, [:x, :y], function], 1, 2]
#
class SchemeR
module Let
  def let?(exp)
    exp[0] == :let
  end
  # eval let expression by converting it into lambda representation.
  def eval_let(exp, env)
    names, values, body = extract_let_exp(exp)
    new_exp = [[:lambda, names, body], *values]
    _eval(new_exp, env)
  end
  def extract_let_exp(exp)
    [
      exp[1].map { |x| x[0] }, 
      exp[1].map { |x| x[1] }, 
      exp[2]
    ]
  end
end
end