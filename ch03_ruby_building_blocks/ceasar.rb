def caesar_cipher(str, num)
	# Split string into an array of letters
	phrase = str.split("")
	# Answer array
	cipher = []
	# Step through each letter in the string
	phrase.each do |l|
		# If letter is a capital...
		if l.ord.between?(65,90) 
			# If letter is at the end of the alphabet...
			if l.ord >= (90 - num + 1)
				# Let cipher move to beginning of alphabet
				cipher << (l.ord - 26 + num).chr
			# Otherwise just move forward in alphabet
			else
				cipher << (l.ord + num).chr
			end
		# If letter is lowercase, follow same instructions as above
		elsif l.ord.between?(97,122)
			if l.ord >= (122 - num + 1)
				cipher << (l.ord - 26 + num).chr
			else
				cipher << (l.ord + num).chr
			end
		# If letter isn't a letter at all (space, period, etc)
		else
			cipher << l
		end
	end
	print cipher.join("")
end

caesar_cipher("What a string!", 5) # => "Bmfy f xywnsl!"