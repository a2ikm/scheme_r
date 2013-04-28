# coding: utf-8
$: << File.dirname(__FILE__)

require "scheme_r/core"
require "scheme_r/list"
require "scheme_r/primitive"
require "scheme_r/immediate"
require "scheme_r/lambda"
require "scheme_r/let"
require "scheme_r/if"
require "scheme_r/letrec"
require "scheme_r/define"
require "scheme_r/cond"
require "scheme_r/parse"

class SchemeR
  include Core
  include List
  include Primitive
  include Immediate
  include Lambda
  include Let
  include If 
  include Letrec
  include Define
  include Cond
  include Parse
end

$global_env = [
  {}, # user defined space
  SchemeR::List::FUNCTIONS, 
  SchemeR::Primitive::FUNCTIONS, 
  SchemeR::If::BOOLEAN,
]
