class Timer
	attr_accessor :seconds

	# If a values has been passed through for seconds, set the @seconds variable to it
	# Otherwise, set seconds to 0
	def initialize
		@seconds ? @seconds = seconds : @seconds = 0
	end

	# Pad single digit numbers with zeros on the left to make them two digit numbers. Will not pad two digit numbers
	def padded(num)
		num.to_s.rjust(2, '0')
	end

	# Calculate the hours, minutes and seconds of the @seconds variable
	def time_string
		hr = @seconds / 60 / 60
		min = (@seconds / 60) - (hr * 60)
		sec = @seconds - (min * 60) - (hr * 60 * 60)
		# Pass each variable through the padded function to get
		# The two digit version of it. Display in 00:00:00 format
		"#{padded(hr)}:#{padded(min)}:#{padded(sec)}"
	end
end