#!/usr/bin/env ruby

require 'rubygems'
require 'thor'

class Runner < Thor

  desc "solve", "solve problems"
  method_option :all, :type => :boolean, :default => true, :aliases => "-a", :desc => "Run all tests"
  method_option :only, :type => :array, :required => false, :aliases => "-o", :desc => "Run specific tests"
  method_option :except, :type => :array, :required => false, :aliases => "-e", :desc => "Exclude specific tests"
  def solve
    # Get RB files, excluding this one, sort by number
    files = Dir['**/*'].grep(/\d+\.rb/i).sort{ |a,b| a.scan(/\d+/).first.to_i <=> b.scan(/\d+/).first.to_i }
    files = files.map{ |e| File.basename(e, '.*') }
    files = files.find_all{|f| options[:only].include?(f)} unless options[:only].nil?
    files = files.find_all{|f| not options[:except].include?(f)} unless options[:except].nil?

    threads = []

    files.each do |file|

      threads << Thread.new {
        problem_num = File.basename(file, '.*')
        start = Time.new
        ans = `ruby #{file}.rb`.strip
        span = (Time.new - start) * 1000.0
        span = (sprintf "%.4f ms", span)
        
        msg = "Problem: #{problem_num}\t"
        msg+= "Solution: #{ans}".widen(30)
        msg+= "Timespan: #{span}"
        puts msg
      }

    end
      
    threads.each(&:join)

  end

  default_task = :all

  no_tasks do
    def capture_stdout(&block)
      original_stdout = $stdout
      $stdout = fake = StringIO.new
      begin
        yield
      ensure
        $stdout = original_stdout
      end
      fake.string
    end
  end
end

class Solution
  def initialize(problem,answer,elapsed)
    @problem = problem
    @answer = answer
    @elapsed = elapsed
  end

  def problem; @problem end
  def answer; @answer end
  def elapsed; @elapsed end
end

class String
  def widen(width)
    wide = self
    while wide.length < 30
      wide = wide.gsub(/$/, ' ')
    end
    wide
  end
end

# !! NOTHING BELOW THIS
#
# Starts the process if this is being used as a script
# If this is being used as a library this will be skipped
if __FILE__ == $0
  Runner.start
end