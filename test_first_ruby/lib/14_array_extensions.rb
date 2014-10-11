# Extend the Array class
class Array 

	# Add each number in the array
	def sum
		inject(0) { |sum, x| sum + x}
	end

	# Square each number in the array
	def square
		map { |x| x*x }
	end

	# Permanently square each number in the array
	def square!
		map! { |x| x*x }
	end
end