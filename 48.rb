# Problem 48
# The series, 11 + 22 + 33 + ... + 1010 = 10405071317.
# Find the last ten digits of the series, 11 + 22 + 33 + ... + 10001000.

puts (1..1000).map{ |e| e ** e }.inject(:+).to_s.split(//).last(10).join()