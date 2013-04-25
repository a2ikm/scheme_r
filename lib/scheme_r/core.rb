# coding: utf-8

class SchemeR
module  Core
  def _eval(exp, env)
    if list?(exp)
      if special_form?(exp)
        eval_special_form(exp, env)
      else
        fun  = _eval(car(exp), env)
        args = eval_list(cdr(exp), env)
        apply(fun, args)
      end
    else
      if immediate?(exp)
        exp
      else
        lookup_var(exp, env)
      end
    end
  end
  def apply(fun, args)
    if primitive?(fun)
      apply_primitive(fun, args)
    else
      apply_lambda(fun, args)
    end
  end
  def lookup_var(name, env)
    vars = env.find { |vars| vars.has_key?(name) }
    raise "couldn't find value to variable: #{name}" if vars.nil?
    vars[name]
  end
  def extend_env(names, values, env)
    vars = names.zip(values).inject({}) { |x, (n, v)| x[n] = v; x }
    [vars] + env
  end
  def special_form?(exp)
    lambda?(exp) || let?(exp)
  end
  def eval_special_form(exp, env)
    if lambda?(exp)
      eval_lambda(exp, env)
    elsif let?(exp)
      eval_let(exp, env)
    end
  end
end
end
