# coding: utf-8

class SchemeR
module Let
  def let?(exp)
    exp[0] == :let
  end
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