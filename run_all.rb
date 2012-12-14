# Get RB files, excluding this one, sort by number
files = Dir.entries(Dir.pwd).grep(/\d+\.rb/i).sort{ |a,b| a.scan(/\d+/).first.to_i <=> b.scan(/\d+/).first.to_i }

files.each { |file|
  problem_num = File.basename(file, '.*')
  print "Problem #{problem_num}: " 
  puts `ruby #{file}`
}


