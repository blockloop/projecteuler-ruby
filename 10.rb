# Problem 10
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
# Find the sum of all the primes below two million.

require './prime.rb'

# puts (2..2000000).find_all(&:prime?).reduce(:+)

total = 0

(2..2000000).each { |n| 
  total+=n if n.prime?
}

puts total