def substrings(word, dictionary)
	phrase = word.split(" ")
	answer = Hash.new(0)
	phrase.each do |word|
		dictionary.each do |dword|
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
