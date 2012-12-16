# Problem 9
# A Pythagorean triplet is a set of three natural numbers, a  b  c, for which,
# a**2 + b**2 = c**2
# For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

x = 1000

def euclids upto 
  result = []
  (2..upto).each do |m| # Start at 2 as 1 results nothing anyway
    (1...m).each do |n| # Euclid's formula only works for m > n
      result << [m**2 - n**2, 2*m*n, m**2 + n**2]
    end
  end
  result
end

euclids(x/2).each do |triple|
  a, b, c = triple[0], triple[1], triple[2]
  if a + b + c == x
    puts a * b * c
    break
  end
end
