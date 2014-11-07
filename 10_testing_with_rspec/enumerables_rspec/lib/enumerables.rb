module Enumerable

	def my_each
		i = 0
		while i < self.length
			yield self[i]
			i += 1
		end
		self
	end

	def my_each_with_index
		i = 0
		while i < self.length
			yield self[i], i
			i += 1
		end
		self
	end

	def my_select
		answer = []
		self.my_each { |n| answer << n if yield n }
		answer
	end

	def my_all?
		checking = 0
		self.my_each do |n| 
			if block_given?
				checking += 1 if !yield n 
			else
				checking += 1 if (n == nil || n == false)
			end
		end
		return true if checking == 0
		return false if checking > 0
	end

	def my_any?
		checking = 0
		self.my_each do |n| 
			if block_given?
				checking += 1 if yield n 
			else
				checking += 1 if (n != nil && n != false)
			end
		end
		return true if checking > 0
		return false if checking == 0
	end

	def my_none?
		checking = 0
		self.my_each do |n|
			if block_given?
				checking += 1 if yield n
			else 
				checking += 1 if (n != nil && n != false)
			end
		end
		return true if checking == 0
		return false if checking > 0
	end

	def my_count(arg = nil)
		checking = 0
		self.my_each do |n|
			if block_given?
				checking += 1 if yield n
			elsif arg == nil
				checking += 1
			else
				checking += 1 if n == arg
			end
		end
		checking
	end

	# Redefined in the next step to take an optional proc
	# def my_map 
	# 	answer = []
	# 	self.my_each { |n| answer << (yield n) }
	# 	answer
	# end

	# Modify your #my_map method to take a proc or a block
	def my_map(&proc)
		answer = []
		if proc
			self.my_each { |n| answer << proc.call(n) }
			answer
		elsif block_given?
			self.my_each { |n| answer << (yield n) }
		end
		answer
	end

	def my_inject(arg = 0)
		self.my_each do |n|
			arg = (yield arg, n)
		end
		arg
	end

	def multiply_els
		self.my_inject(1) { |result, num| result * num }
	end

	# Odin's instructions: "Modify your #my_map method to take either a proc or a block, executing the block only if both are supplied (in which case it would execute both the block AND the proc)." 

	# Little confused. The first sentence says EITHER a block or a proc. And then ONLY do the block if a proc is supplied. Why are we not doing the block unless a proc is supplied? What are we returning if only a block is supplied? The original array? 

	# And in which order do we do them? If my Proc multiplies each number by 3 and my block checks if the number is less than 4, do we check if the number is less than 4 and THEN multiply by 3? Or multiply by 3 and THEN check if it's less than 4?

	# In order to make sense of this I'm going to make some assumptions:
	# If a proc and a block are both supplied, run each element through the block, then pass to proc
	# If only one is given, just pass the element to the one given

	# This doesn't work. IRB complains that both a proc and a block were given. 
	# It's worth noting, however, that IRB complains when the regular #map function is given both a block and a proc, as well. So I'm in good company. Maybe I'm misunderstanding the instructions... 
	def my_map_2(proc = nil, &block)
		answer = []
		if proc && block_given?
			self.my_each { |n| answer << proc.call(yield(n)) }
		elsif proc && !block_given?
			self.my_each { |n| proc.call(n) }
		elsif proc.nil? && block_given?
			self.my_each { |n| answer << (yield n) }
		else
			self
		end
		answer
	end

end