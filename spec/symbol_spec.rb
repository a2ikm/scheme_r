# coding: utf-8
require "spec_helper"

describe SchemeR::Symbol do
  specify { SchemeR::Symbol.new(:a).should be_equal SchemeR::Symbol.new(:a) }
  specify { SchemeR::Symbol.new(:a).should == SchemeR::Symbol.new(:a) }
end
