def substrings(word, dictionary)
	# Split word into an array in case it is a phrase
	phrase = word.split(" ")
	# Set up answer hash
	answer = Hash.new(0)
	# Step through each word in the phrase
	phrase.each do |word|
		# Step through each word in the dictionary
		dictionary.each do |dword|
			# If the word includes the dictionary word, add one to the dictionary word in the answer hash
			if word.downcase.include?(dword)
				answer[dword] += 1
			end
		end
	end
	print answer
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("below", dictionary) # => {"below"=>1, "low"=>1}

substrings("Howdy partner, sit down! How's it going?", dictionary)
	# => {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}
