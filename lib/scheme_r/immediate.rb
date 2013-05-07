# coding: utf-8

require "scheme_r/symbol"

class SchemeR
module Immediate
  def immediate?(exp)
    numeric?(exp) || symbol?(exp)
  end
  def numeric?(exp)
    exp.is_a?(Numeric)
  end
  def symbol?(exp)
    exp.is_a?(SchemeR::Symbol)
  end
end
end
