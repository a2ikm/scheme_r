# coding: utf-8

class SchemeR
module Immediate
  def immediate?(exp)
    numeric?(exp)
  end
  def numeric?(exp)
    exp.is_a?(Numeric)
  end
end
end