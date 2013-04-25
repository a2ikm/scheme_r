#!/usr/bin/env ruby
# coding: utf-8

class SchemeR
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
      if immediate_value?(exp)
        exp
      else
        lookup_var(exp, env)
      end
    end
  end
  PRIMITIVE_FUN = {
    :+ => [:prim, lambda { |x, y| x + y }],  
    :- => [:prim, lambda { |x, y| x - y }],
    :* => [:prim, lambda { |x, y| x * y }],
    :/ => [:prim, lambda { |x, y| x / y }],
  }
  def eval_list(list, env)
    list.map { |exp| _eval(exp, env) }
  end
  def apply(fun, args)
    if primitive_fun?(fun)
      apply_primitive_fun(fun, args)
    else
      apply_lambda(fun, args)
    end
  end
  def car(list)
    list[0]
  end
  def cdr(list)
    list[1..-1]
  end
  def immediate_value?(exp)
    numeric?(exp)
  end
  def numeric?(exp)
    exp.is_a?(Numeric)
  end
  def list?(exp)
    exp.is_a?(Array)
  end
  def apply_primitive_fun(fun, args)
    fun[1].call(*args)
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
  def eval_let(exp, env)
    names, values, body = extract_let_exp(exp)
    new_exp = [[:lambda, names, body], *values]
    _eval(new_exp, env)
  end
  def extract_let_exp(exp)
    [
      exp[1].map { |x| x[0] }, 
      exp[1].map { |x| x[1] }, 
      exp[2]
    ]
  end
  def let?(exp)
    exp[0] == :let
  end
  def eval_lambda(exp, env)
    make_closure(exp, env)
  end
  def make_closure(exp, env)
    names, body = exp[1, 2]
    [:closure, names, body, env]
  end
  def apply_lambda(closure, values)
    names, body, env = extract_closure_exp(closure)
    new_env = extend_env(names, values, env)
    _eval(body, new_env)
  end
  def extract_closure_exp(closure)
    closure[1..3]
  end
  def special_form?(exp)
    lambda?(exp) || let?(exp)
  end
  def lambda?(exp)
    exp[0] == :lambda
  end
  def eval_special_form(exp, env)
    if lambda?(exp)
      eval_lambda(exp, env)
    elsif let?(exp)
      eval_let(exp, env)
    end
  end
  def primitive_fun?(exp)
    exp[0] == :prim
  end
end

$global_env = [SchemeR::PRIMITIVE_FUN]
