# Add two numbers
def add(n1, n2)
	n1 + n2
end

# Subtract second number from first
def subtract(n1, n2)
	n1 - n2
end

# Add an array of numbers. The inject method works perfectly here!
def sum(nums)
	nums.inject(0) { |sum, num| sum + num }
end

# Multiply several numbers together (spec said *two* numbers together, but test requires ability to multiply several numbers together. Therefor I'm using *nums, to convert a list of numbers to an array to act on. NOT going to assume the input is always an array.)
def multiply(*nums)
	# inject(1) to make result start at 1, otherwise we'd always be multiplying by zero!
	nums.inject(1) { |result, num| result * num}
end

# Raise first number to power of second number
def power(n1, n2)
	n1**n2
end

# Compute factorial of given number. A factorial is the product of all the integers between 1 and the given number. Except 0, who has a factorial of 1. Go figure. 
def factorial(num)
	result = 1
	1.upto(num) { |n| result *= n }
	result
end