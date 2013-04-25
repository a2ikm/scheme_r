# coding: utf-8

class SchemeR
module Lambda
  def lambda?(exp)
    exp[0] == :lambda
  end
  def eval_lambda(exp, env)
    make_closure(exp, env)
  end
  def make_closure(exp, env)
    names, body = exp[1, 2]
    [:closure, names, body, env]
  end
  def apply_lambda(closure, values)
    names, body, env = extract_closure_exp(closure)
    new_env = extend_env(names, values, env)
    _eval(body, new_env)
  end
  def extract_closure_exp(closure)
    closure[1..3]
  end
end
end