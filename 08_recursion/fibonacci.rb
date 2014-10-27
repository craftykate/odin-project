def fibs(num)
	answer = []
	0.upto(num) do |n|
		if n < 2
			answer << n
		else
			answer << (answer[-1] + answer[-2])
		end
	end
	answer.last
end

def fibs_rec(num)
	num < 2 ? num : (fibs_rec(num - 1) + fibs_rec(num - 2))
end

puts fibs(0) # => 0
puts fibs(1) # => 1
puts fibs(2) # => 1
puts fibs(3) # => 2
puts fibs(6) # => 8
puts fibs(10) # => 55

puts fibs_rec(0) # => 0
puts fibs_rec(1) # => 1
puts fibs_rec(2) # => 1
puts fibs_rec(3) # => 2
puts fibs_rec(6) # => 8
puts fibs_rec(10) # => 55