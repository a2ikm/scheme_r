# coding: utf-8
class SchemeR
module Letrec
  def letrec?(exp)
    exp[0] == :letrec
  end
  def eval_letrec(exp, env)
    names, values, body = extract_letrec_exp(exp)
    
    dummy = names.inject({}) { |s, n| s[n] = :dummy; s }
    _env = extend_env(dummy.keys, dummy.values, env)
    _values = eval_list(values, _env)

    extend_env!(names, _values, _env)
    new_exp = [[:lambda, names, body], *values]
    _eval(new_exp, _env)
  end
  def extract_letrec_exp(exp)
    extract_let_exp(exp)
  end
end
end
