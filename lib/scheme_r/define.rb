# coding: utf-8

#
#   [:define, [:id, :x], :x]
# 
# or
#
#   [:define, :id, [:lambda, [:x], :x]]
#
class SchemeR
module Define
  def define?(exp)
    exp[0] == :define
  end
  def eval_define(exp, env)
    name, val =
      if define_with_parameter?(exp)
        extract_define_with_parameter_exp(exp)
      else
        extract_define_exp(exp)
      end

    var_ref = lookup_var_ref(name, env)
    if var_ref
      var_ref[name] = _eval(val, env)
    else
      extend_env!([name], [_eval(val, env)], env)
    end
    nil
  end
  def define_with_parameter?(exp)
    list?(exp[1])
  end
  def extract_define_with_parameter_exp(exp)
    name = car(exp[1])
    parameters = cdr(exp[1])
    body = exp[2]
    
    val = [:lambda, parameters, body]
    [name, val]
  end
  def extract_define_exp(exp)
    exp[1..2]
  end
end
end
