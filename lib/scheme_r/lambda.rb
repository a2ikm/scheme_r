# coding: utf-8

# lambda represents user-defined function.
# 
#   [:lambda, [:x, :y], function]
#
class SchemeR
module Lambda
  def lambda?(exp)
    exp[0] == :lambda
  end
  # convert a lambda expression like:
  #
  #   [:lambda, [:x, :y], function]
  #
  # to closure representation enclosing env like:
  #
  #   [:closure, [:x, :y], function, env]
  #
  def eval_lambda(exp, env)
    make_closure(exp, env)
  end
  def make_closure(exp, env)
    names, body = exp[1, 2]
    [:closure, names, body, env]
  end
  # read arguments' names, function body, and env from closure representation,
  # and eval the function in the extended env with its names and passed values.
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