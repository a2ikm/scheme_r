# coding: utf-8

#
#   [:closure, [:x, :y], body, env]
#
class SchemeR
module Closure
  def closure?(exp)
    exp[0] == :closure
  end
end
end
