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
      line = prompt or return

      exit if line.strip == "quit"
      exit if line.strip == "exit"
      help or next if line.strip == "help"

      while line.count("(") > line.count(")")
        next_line = prompt2 or return
        line += next_line
      end
      redo if line =~ /\A\s*\z/m
      begin
        val = @s._eval(@s.parse(line), @env)
        puts @s._pp(val)
      rescue Exception => e
        puts "#{e.class} : #{e.message}"
        redo
      end
    end
  end

  private

  def prompt
    print ">>> "
    gets
  rescue Interrupt
    exit
  end

  def prompt2
    print ">>  "
    gets
  rescue Interrupt
    exit
  end

  def help
    puts "Type `quit` or `exit` to exit repl."
    puts "Type `help` to display this help message."
    puts
  end
end
end
