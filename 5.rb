# Problem 5
# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

def gcd(a, b)
  while b != 0
    t = b
    b = (a%b)
    a = t
  end
  a
end

# lcm = product of x*y divided by the gcd of x & y
def lcm(x, y)
  (x*y) / gcd(x, y)
end

result = 1
a = 1

(1..20).each{|i|
  result = lcm(i, result)
}

puts result
