def stock_picker(prices)
	# Define the variables, set to zero.
	overall_biggest_difference = 0
	overall_best_days = []
	todays_biggest_difference = 0
	todays_best_day = []
	# Step through each day in the array
	prices.each_with_index do |price, i|
		# Reset today's variables
		todays_biggest_difference = 0
		todays_best_day = []
		# As long as the day isn't the last day
		if i != prices.length - 1
			# Compare every day after the current day
			# The day after is j and is initially set to the day after the current day
			j = i+1
			# Step through every day AFTER the current day (no going backwards in time!)
			until j == prices.length - 1
				# If the range between the checked day and the current day is the biggest...
				if (prices[j] - price) > todays_biggest_difference
					# Store the range
					todays_biggest_difference = prices[j] -  price
					# And store the days
					todays_best_day = [i, j]
				end
				# Check the next day
				j += 1
			end
			# At the end of the current day, check if the current day's difference is bigger than all the last biggest difference
			if todays_biggest_difference > overall_biggest_difference
				# If so, store the new biggest difference
				overall_biggest_difference = todays_biggest_difference
				# And store the range of days
				overall_best_days = todays_best_day
			end
		end
		# Move on to the next day in the original array, wash, rinse and repeat
	end
	# And voila, here's your combination of best days to buy and sell
	print overall_best_days
end

stock_picker([17,3,6,9,15,8,6,1,10]) # => [1,4]  