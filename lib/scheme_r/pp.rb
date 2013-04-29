# coding: utf-8

#
# pretty print
#
class SchemeR
module PP
  def _pp(exp)
    if exp.is_a?(Symbol) || numeric?(exp)
      exp.to_s
    elsif exp.nil?
      ""
    elsif exp.is_a?(Array) && closure?(exp)
      names, body, env = extract_closure_exp(exp)
      "(closure #{_pp(names)} #{_pp(body)})"
    elsif exp.is_a?(Array) && lambda?(exp)
      names, body = exp[1, 2]
      "(lambda #{_pp(names)} #{_pp(body)})"
    elsif exp.is_a?(Hash)
      if exp == Primitive::FUNCTIONS
        "*primitive*"
      elsif exp == If::BOOLEAN
        "*boolean*"
      elsif exp == List::FUNCTIONS
        "*list*"
      else
        "{" + exp.map { |k,v| [_pp(k), _pp(v)].join(":") }.join(", ") + "}"
      end
    elsif exp.is_a?(Array)
      "(" + exp.map { |e| _pp(e) }.join(", ") + ")"
    else
      exp.to_s
    end
  end
end
end
