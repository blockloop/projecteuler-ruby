#!/usr/bin/env ruby

require 'rubygems'
require 'thor'
require 'table_print'

class Runner < Thor

  desc "solve", "solve problems"
  method_option :all, :type => :boolean, :default => true, :aliases => "-a", :desc => "Run all tests"
  method_option :only, :type => :array, :required => false, :aliases => "-o", :desc => "Run specific tests"
  method_option :except, :type => :array, :required => false, :aliases => "-e", :desc => "Exclude specific tests"
  def solve
    # Get RB files, excluding this one, sort by number
    files = Dir['**/*'].grep(/\d+\.rb/i).sort{ |a,b| a.scan(/\d+/).first.to_i <=> b.scan(/\d+/).first.to_i }
    files = files.map{ |e| File.basename(e, '.*') }
    files = files.select{|f| options[:only].include?(f)} unless options[:only].nil?
    files = files.select{|f| not options[:except].include?(f)} unless options[:except].nil?

    # put header
    # tp Solution.new("", "", "")

    solutions = files.map { |file|
      problem_num = File.basename(file, '.*')
      start = Time.new
      ans = `ruby #{file}.rb`.strip
      span = (Time.new - start) * 1000.0
      span = (sprintf "%.4f ms", span)
      Solution.new(problem_num,ans,span)
    }

    tp solutions
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



# !! NOTHING BELOW THIS
#
# Starts the process if this is being used as a script
# If this is being used as a library this will be skipped
if __FILE__ == $0
  Runner.start
end