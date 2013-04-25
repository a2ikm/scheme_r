# coding: utf-8
$: << File.dirname(__FILE__)

require "scheme_r/core"
require "scheme_r/list"
require "scheme_r/primitive"
require "scheme_r/immediate"
require "scheme_r/lambda"
require "scheme_r/let"

class SchemeR
  include Core
  include List
  include Primitive
  include Immediate
  include Lambda
  include Let
end

$global_env = [SchemeR::Primitive::FUNCTIONS]
