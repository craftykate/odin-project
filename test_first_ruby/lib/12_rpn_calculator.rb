class RPNCalculator

	# @calculator is where we store our numbers. Set to an empty array when starting
	# @result is where we store the result of adding, subtracting etc
	def initialize
		@calculator = []
		@result = 0
	end

	# Push a number into the calculator array to hold it for calculating
  def push(num)
  	@calculator << num
  end

  # This happens each time we need to calculate on two numbers so I separated it out into its own function.
  # This grabs the last two numbers from the array, removes them from the array, then returns the two numbers to the function calling it
  def get_nums
  	n2 = @calculator[-1]
  	@calculator.pop
  	raise "calculator is empty" if @calculator[-1] == nil
  	n1 = @calculator[-1]
  	@calculator.pop
  	yield(n1, n2)
  end

  # Add two numbers, put the result back into the calculator.
  # If this is the last function called, the answer will still be in @result.
  # Same for minus, times, and divide
  def plus
  	get_nums do |n1, n2| 
  		@result = n1 + n2
  		@calculator << @result 
  	end
  end

  def minus
  	get_nums do |n1, n2| 
  		@result = n1 - n2
  		@calculator << @result 
  	end
  end

  def times
  	get_nums do |n1, n2| 
  		@result = n1 * n2
  		@calculator << @result 
  	end
  end

  def divide
  	get_nums do |n1, n2| 
  		@result = n1.to_f / n2.to_f
  		@calculator << @result 
  	end
  end

  # Display whatever is in the result
  def value
  	@result
  end

  # Tokenizes an array. Splits the string into an array, if the item is a digit it turns it back into an integer, if it's not a digit it turns it into a symbol
  def tokens(string)
  	(string.split.map { |i| i.match(/\d+/) ? i.to_i : i.to_sym})
  end

  def evaluate(eval)
  	# Reset result. Important!
  	@result = nil
  	#Tokenize the string to evaluate
  	functions = tokens(eval)
  	# Step through each item to evaluate
  	functions.each do |x|
  		# If it's an integer, store it in @calculator
  		@calculator << x if x.is_a?(Integer)
  		# if it's a function, run that method
  		plus if x == :+
  		minus if x == :-
  		times if x == :*
  		divide if x == :/
  	end
  	# And voila, here's your result
  	value	
  end

end
