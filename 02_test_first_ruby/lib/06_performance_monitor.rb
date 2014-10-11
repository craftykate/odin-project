# I'm honestly not totally sure I got this one right. I found very little documentation on what Time stubbing is. But checking what time it is now and subtracting it from the time it is when the program is done seemed like the natural way to see how much time had elapsed... And then I divided it by the number of times the program ran to get the average time.
def measure(num = 1, &block)
	start = Time.now
	num.times { block.call }
	ending = Time.now
	return ((ending - start) / num)
end