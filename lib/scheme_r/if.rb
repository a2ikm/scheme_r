# coding: utf-8
class SchemeR
module If
  BOOLEAN = { true: true, false: false }
  def eval_if(exp, env)
    cond, true_clause, false_clause = extract_if_exp(exp)
    if _eval(cond, env)
      _eval(true_clause, env)
    else
      _eval(false_clause, env)
    end
  end
  def if?(exp)
    exp[0] == :if
  end
  def extract_if_exp(exp)
    exp[1..3]
  end
end
end
