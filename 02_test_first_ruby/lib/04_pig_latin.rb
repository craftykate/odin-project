# Translate a phrase into Pig Latin
def translate(phrase)
	answer = []
	vowels = 'aeiouAEIOU'
	cons = 'bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ'
	# Step through each word in the phrase
	phrase.split.each do |word|
		# If the word begins with a vowel, put the word with "ay" at the end
		if word[0].match(/[#{vowels}]/)
			answer << (word + "ay")
		end
		# If the word begins with a consonant...
		if word[0].match(/[#{cons}]/)
			# Set the punctuation variable to an empty string
			punc = ''
			# If the last letter is something other than a letter...
			if word[-1].match(/\W/)
				# Store that punctuation and pop it off the word
				punc = word[-1]
				word = word[0..-2]
			end
			# So, turns out that words like "why" and "my" don't get translated right. If the only vowel in a word is "y", redefine the consonants string so that "y" is no longer a consonant. I waffled on words like "psychology". Is "psychology" "ologypsychay"? Or "ychologypsay"? For me, personally, I feel like the first consonant sound is "psych", so this works perfectly.
			# Test if word has no "vowels" (meaning, its only vowel is a "y")
			if !word.match(/[#{vowels}]/)
				# If so, consonants now DON'T include the letter "y"
				cons = 'bcdfghjklmnpqrstvwxzBCDFGHJKLMNPQRSTVWXZ'
			end
			# Take the first batch of consonants to move to the end
			last = word.match(/[#{cons}]+/).to_s
			# If the last letter of the consonant string is a "q" and the first letter of the rest of the word is a "u", take off the "u" to add back later
			if last[-1] == "q" && word[(last.length)] == "u"
				first = word[(last.length + 1)..-1].to_s
				# And capitalize the first letter of the new word if the original word was capitalized
				first = first.capitalize if word[0] == word[0].upcase
				# The word is now the end of the original word, plus the beginning (downcased in case it was capitalized) plus the pig latin part
				answer << (first +  last.downcase + "uay" + punc)
			else
				# The consonant string doesn't end with a "qu", so proceed as normal
				first = word[(last.length)..-1].to_s
				first = first.capitalize if word[0] == word[0].upcase
				answer << (first +  last.downcase + "ay" + punc)
			end
		end
	end
	answer.join(' ')
end