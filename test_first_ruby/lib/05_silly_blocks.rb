# Reverse the string in the block by calling the string in the block, splitting it into an array, reversing each word in the array and joining the result into a string
def reverser(&block)
	answer = []
	answer = (block.call.split.map { |word| word.reverse} ).join(' ')
end

# Adds a number (default is 1 if not supplied) to the number in the block
def adder(num = 1, &block)
	block.call + num
end

# Repeats a block a given number of times (default is 1, if no number is supplied)
def repeater(num = 1, &block)
	num.times { block.call }
end