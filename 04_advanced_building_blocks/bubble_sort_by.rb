def bubble_sort_by(arr)
	# Each round, the longest word gets put at the end. The next round, the second longest word gets put before the last word and so on. This means that each round we need to check one less amount of words. If the array had 5 words the first round we would check the first four words. The second round we would check 3 words etc. 

	# So, the variable "round" decides how many words we need to check. 
	round = arr.length - 1
	loop do
		# Set up our index variable
		i = 0
		# A little checking variable. If words get swapped this variable increases. We can stop the program if we've completed a round and the checking variable is still 0. This means the array is already in order and we can stop.
		check = 0
		# Until the word we're looking at is the second to last...
		until i == round
			# "word" is the current word
			word = arr[i]
			# "next_word" is the word after the current one
			next_word = arr[i+1]
			# If they're not in order, swap them
			if (yield word, next_word) < 0
				arr[i] = next_word
				arr[i+1] = word
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

bubble_sort_by(["hi","how's it going","hello","hey"]) do |left,right|
  right.length - left.length
end

# => ["hi", "hey", "hello", "how's it going"]
