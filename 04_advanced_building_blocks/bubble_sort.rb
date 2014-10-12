def bubble_sort(arr)
	# Each round, the highest number gets put at the end. The next round, the second highest number gets put before the last number and so on. This means that each round we need to check one less amount of numbers. If the array had 5 numbers the first round we would check the first four numbers. The second round we would check 3 numbers etc. 

	# So, the variable "round" decides how many numbers we need to check. 
	round = arr.length - 1
	loop do
		# Set up our index variable
		i = 0
		# A little checking variable. If numbers get swapped this variable increases. We can stop the program if we've completed a round and the checking variable is still 0. This means the array is already in order and we can stop.
		check = 0
		# Until the number we're looking at is the second to last...
		until i == round
			# "num" is the current number
			num = arr[i]
			# "next_num" is the number after the current one
			next_num = arr[i+1]
			# If they're not in order, swap them
			if next_num < num
				arr[i] = next_num
				arr[i+1] = num
				# And increase the checking variable
				check += 1
			end
			# Move on to the next number
			i += 1
		end
		# If the last round was already sorted, end the loop
		break if check == 0
		# Move on to the next round
		round -= 1
	end
	print arr
end

bubble_sort([16,99,18,7,4,3,10,78,2,0,14,2,56]) # => [0, 2, 2, 3, 4, 7, 10, 14, 16, 18, 56, 78, 99]