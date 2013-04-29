# coding: utf-8

#
# Replace variable in env
#
class SchemeR
module Setq
  def setq?(exp)
    exp[0] == :setq
  end
  def eval_setq(exp, env)
    name, value = extract_setq(exp)
    var_ref = lookup_var_ref(name, env)
    raise "undefined variable: #{name}" if var_ref.nil?
    var_ref[name] = _eval(value, env)
    nil
  end
  def extract_setq(exp)
    exp[1..2]
  end
end
end
