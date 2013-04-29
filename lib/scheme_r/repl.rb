# coding: utf-8

require File.expand_path("../../scheme_r.rb", __FILE__)

class SchemeR
class REPL
  def self.start(env = $global_env)
    new(env).start
  end
  def initialize(env = $global_env)
    @env = env
    @s   = ::SchemeR.new
  end
  def start
    loop do
      prompt
      line = gets or return
      while line.count("(") > line.count(")")
        prompt2
        next_line = gets or return
        line += next_line
      end
      redo if line =~ /\A\s*\z/m
      begin
        val = @s._eval(@s.parse(line), @env)
      rescue Exception => e
        puts "#{e.class} : #{e.message}"
        redo
      end
      puts val
    end
  end

  private

  def prompt
    print ">>> "
  end

  def prompt2
    print ">>  "
  end
end
end
