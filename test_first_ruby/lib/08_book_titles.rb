class Book
  attr_accessor :title

  # Redefine the @title variable
  def title
  	# Define which words should not be capitalized
  	little_words = ['the','a','an','and','in','of']
		answer = []
		# Split the title and step through each word
		@title.split.each_with_index do |word, i| 
			# If it's the first word, or the word isn't a little word, capitalize it
			answer << ((i == 0 || !little_words.include?(word)) ? word.capitalize : word)
		end
		# The title is now the answer variable joined as a string
		@title = answer.join(' ')
  end
end
