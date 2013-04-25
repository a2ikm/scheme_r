# coding: utf-8
require "spec_helper"

describe SchemeR do
  let(:s) { SchemeR.new }

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
end
