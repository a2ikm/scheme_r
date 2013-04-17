# coding: utf-8
require "spec_helper"

describe SchemeR do
  let(:s) { SchemeR.new }

  describe "#_eval" do
    specify { s._eval(1).should == 1 }
    specify { s._eval(:+).should == SchemeR::PRIMITIVE_FUN[:+] }
    specify { s._eval([:+, 1, 3]).should == 4 }
  end

  describe "#car" do
    specify { s.car([1, 2, 3]).should == 1 }
    specify { s.car([7, 8, 9]).should == 7 }
  end

  describe "#cdr" do
    specify { s.cdr([1, 2, 3]).should == [2, 3] }
    specify { s.cdr([7, 8, 9]).should == [8, 9] }
  end
end
