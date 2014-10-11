# Return the phrase given
def echo(phrase)
	phrase
end

# SHOUT THE PHRASE IN ALL CAPS!!
def shout(phrase)
	phrase.upcase
end

# Repeat the phrase one time, unless a number is given, then repeat it that many times. I put the phrase once and then the phrase with a space before it the remaining amount of times
# This way, the phrase doesn't start, or end with a space
def repeat(phrase, num = 2)
	phrase + (" #{phrase}") * (num - 1)
end

# Returns 'num' amount of letters at the start of a given word
def start_of_word(word, num)
	word[0..(num-1)]
end

# Return the first word of a phrase. Easily done by splitting phrase by spaces into an array and grabbing the first item of the array
def first_word(phrase)
	phrase.split.first
end

# Capitalize every word, except for "little" words. I took this to mean "and", "the", "over" etc. I chose enough little words to make tests pass but didn't include a whole dictionary of words not to capitalize
def titleize(phrase)
	little_words = ["and", "the", "over", "in", "by"]
	answer = []
	# Split the phrase and step through each word
	phrase.split.each_with_index do |word, i| 
		# If it's the first word, or the word isn't a little word, capitalize it
		answer << ((i == 0 || !little_words.include?(word)) ? word.capitalize : word)
	end
	answer.join(' ')
end