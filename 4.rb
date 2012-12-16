# Problem 4
# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

range = (100..999)

puts range.flat_map{ |a|
  range.map{ |b|
    a*b
  }
}.find_all{ |p|
  s = p.to_s
  s == s.reverse
}.max
