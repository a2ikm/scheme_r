# coding: utf-8
class SchemeR
module Parse
  DELIMITERS = '\(\)\s^'
  def parse(exp)
    program = exp.strip.
                  gsub(/'(?<paren>\((?:[^()]|\g<paren>)*\))/, '(quote \k<paren>)').
                  gsub(/(?<=[#{DELIMITERS}])[a-zA-Z\+\-\*><=][0-9a-zA-Z\+\-=!*]*/, ':\0').
                  gsub(/\s+/, ', ').
                  gsub(/\(/, '[').
                  gsub(/\)/, ']').
                  gsub(/'([a-zA-Z][_a-zA-Z0-9]*)/, 'SchemeR::Symbol.new("\1")')
    eval(program)
  end
end
end
