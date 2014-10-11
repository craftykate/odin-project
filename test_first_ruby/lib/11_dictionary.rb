class Dictionary
  
  # Set up an empty hash
  def initialize
  	@words = Hash.new
  end

  # Get @words hash when entries is called
  def entries
  	@words
  end

  def add(word)
  	# Turn a string into a hash if just a single word was added
  	# Makes default definition nil
  	word = {word => nil} if word.is_a?(String)
  	# Add item and definition to @words hash
  	word.each { |item, definition| @words[item] = definition }
  end

  def keywords
  	# Get just the keywords out of the words hash and sort them
  	@words.keys.sort
  end

  def include?(word)
  	# Build in include function to check if words has includes given word
  	@words.include?(word)
  end

  def find(word)
  	answer = {}
  	# Here we need to find a word by any number of letters that it could start with
 		# Go through each pair in the words hash... 
  	@words.map do |item, definition|
  		# Add to the answer hash the word and definition if the first part of the item is the same as the word being searched
  		# Finds "first part" by seeing how many letters the search term is
  		answer[item] = definition if item[0..(word.length - 1)] == word
  	end
  	answer
  end

  def printable
  	all_words = ""
  	i = 0
  	@words.sort.each do |item,definition|
  		# If it's the first result, add the following
  		all_words += "[#{item}] \"#{definition}\"" if i == 0
  		# If it's any other result, start with a newline. This keeps the string from ending with a newline. Or starting with one. 
  		all_words += "\n[#{item}] \"#{definition}\"" if i > 0
  		i += 1
  	end
  	all_words
  end
end
