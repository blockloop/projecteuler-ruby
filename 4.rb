# Problem 4
# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

ans = (100..999).map{ |a|
  (100..999).map{ |b|
    a*b
  }
}.flatten.select{ |p|      # select those, which are reversed
  p.to_s == p.to_s.reverse # the same as non-reversed
}.sort.reverse.first

puts ans