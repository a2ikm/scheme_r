# coding: utf-8
require "spec_helper"

describe SchemeR do
  let(:s) { SchemeR.new }

  describe "#parse" do
    specify { s.parse("(let (x 1) (+ x 2))").should == [:let, [:x, 1], [:+, :x, 2]] }
    specify { s.parse("'(+ 1 2)").should == [:quote, [:+, 1, 2]] }
    specify { s.parse("'(+ (+ 1 2) 3)").should == [:quote, [:+, [:+, 1, 2], 3]] }
    specify { s.parse("(foo)").should == [:foo] }
    specify { s.parse("'foo").should == SchemeR::Symbol.new(:foo) }
    specify { s.parse("('foo)").should == [SchemeR::Symbol.new(:foo)] }
  end

  describe "#_eval" do
    specify { s._eval(1, $global_env).should == 1 }
    specify { s._eval([:+, 1, 3], $global_env).should == 4 }
    specify {
      exp = [:lambda, [:x, :y], [:+, :x, :y]]
      s._eval(exp, $global_env).should == [:closure, [:x, :y], [:+, :x, :y], $global_env]
    }
    specify {
      exp = [[:lambda, [:x, :y], [:+, :x, :y]], 1, 2]
      s._eval(exp, $global_env).should == 3
    }
    specify {
      exp = [:let, [[:x, 1], [:y, 2]], [:+, :x, :y]]
      s._eval(exp, $global_env).should == 3
    }
    specify {
      exp = [:let, [[:x,  2]], 
              [:let, [[:fun, [:lambda, [], :x]]], 
                [:let, [[:x, 1]], 
                  [:fun]]]]
      s._eval(exp, $global_env).should == 2
    }
    specify { s._eval([:>, 1, 0], $global_env).should be_true }
    specify { s._eval([:>, 1, 0], $global_env).should be_true }
    specify {
      exp = [:if, [:>, 1, 0], 1, 2]
      s._eval(exp, $global_env).should == 1
    }
    specify { s._eval(:true,  $global_env).should == true }
    specify { s._eval(:false, $global_env).should == false }
    specify {
      exp = [:letrec, 
             [[:fact, 
              [:lambda, [:n], [:if, [:<, :n, 1], 1, [:*, :n, [:fact, [:-, :n, 1]]]]]]], 
             [:fact, 3]]
      s._eval(exp, $global_env).should == 6
    }
    specify {
      exp = [:define, [:length, :list], 
             [:if,
              [:null?, :list], 
              0, 
              [:+, 1, [:length, [:cdr, :list]]]]]
      s._eval(exp, $global_env)
      s._eval([:length, [:list, 1, 2, 3]], $global_env).should == 3
    }
    specify {
     exp = [:cond,
            [[:>, 1, 1], 1],
            [[:>, 2, 1], 2],
            [[:>, 3, 1], 3],
            [:else, -1]] 
     s._eval(exp, $global_env).should == 2
    }
    specify {
      s._eval([:quote, [:+, 1, 2]], $global_env).should == [:+, 1, 2]
    }
  end

  describe "#car" do
    specify { s.car([1, 2, 3]).should == 1 }
    specify { s.car([7, 8, 9]).should == 7 }
  end

  describe "#cdr" do
    specify { s.cdr([1, 2, 3]).should == [2, 3] }
    specify { s.cdr([7, 8, 9]).should == [8, 9] }
  end

  describe "#lookup_var" do
    specify {
      env = [{ x: 1, y:2 }, { x: 3, y: 4 }]
      s.lookup_var(:x, env).should == 1
    }
  end

  describe "#extend_env" do
    specify {
      env = [{ x: 1, y: 2 }]
      adding_vars = { x: 3, y: 4 }
      s.extend_env(adding_vars.keys, adding_vars.values, env).should ==
        [adding_vars, env].flatten
    }
  end

  describe "#extract_let_exp" do
    specify {
      s.extract_let_exp([:let, [[:x, 1], [:y, 2]], [:+, :x, :y]]).should ==
      [[:x, :y], [1, 2], [:+, :x, :y]]
    }
  end

  describe "#let?" do
    specify {
      s.let?([:let, [[:x, 1]], [:lambda, [], :x]]).should be_true
    }
    specify {
      s.let?([:lambda, [], :x]).should be_false
    }
  end

  describe "#eval_lambda" do
    specify {
      s.eval_lambda([:lambda, [:x, :y], :function], []).should ==
        [:closure, [:x, :y], :function, []]
    }
  end

  describe "#extract_closure_exp" do
    specify {
      s.extract_closure_exp([:closure, [:x, :y], :function, []]).should ==
        [[:x, :y], :function, []]
    }
  end

  describe "#apply_lambda" do
    specify {
      s.apply_lambda([:closure, [:x, :y], [:+, :x, :y], $global_env], [1, 2]).should == 3
    }
  end

  describe "#list" do
    specify { s._eval([:list, 1, 2, 3], $global_env).should == [1, 2, 3] }
  end

  describe "#null?" do
    specify { s._eval([:null?, [:list]], $global_env).should be_true }
    specify { s._eval([:null?, [:list, 1]], $global_env).should be_false }
  end

  describe "#car" do
    specify { s._eval([:car, [:list, 1, 2]], $global_env).should == 1 }
  end

  describe "#cdr" do
    specify { s._eval([:cdr, [:list, 1, 2]], $global_env).should == [2] }
  end

  describe "#cons" do
    specify { s._eval([:cons, 1, [:list, 2]], $global_env).should == [1, 2] }
  end
end
