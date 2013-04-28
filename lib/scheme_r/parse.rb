# coding: utf-8
class SchemeR
module Parse
  def parse(exp)
    program = exp.strip.
                  gsub(/'(?<paren>\((?:[^()]|\g<paren>)*\))/, '(quote \k<paren>)').
                  gsub(/[a-zA-Z\+\-\*><=][0-9a-zA-Z\+\-=!*]*/, ':\0').
                  gsub(/\s+/, ', ').
                  gsub(/\(/, '[').
                  gsub(/\)/, ']')
    eval(program)
  end
end
end
