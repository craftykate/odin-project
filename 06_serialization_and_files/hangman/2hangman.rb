class Hangman

	def initialize
		words = File.readlines('wordlist.txt')
		valid_words = []
		words.each do |w| 
			w.gsub!(/\r\n/, "") 
			valid_words << w if w.length.between?(5,12) && w[0] != w[0].upcase
		end
		@word = valid_words.sample.split("").to_a
		@guess = ""
		@word.length.times { @guess += "_"}
		@wrong_letters = ""
		9.times { @wrong_letters += "_"}
		@turn = 0
		intro
	end

	def intro
		puts
		puts "Welcome to Hangman!"
		puts "Your task is to guess the secret word, letter by letter."
		puts "You have only 9 wrong letters before you lose, so guess carefully!"
		puts
		puts "Here is your word. Each _ is a letter."
		puts
		get_guess
	end

	def show_board
		puts "You have use #{@turn} of 9 turns."
		puts
		puts "Word:   #{@guess.split("").join(" ")}"
		puts
		puts "Misses: #{@wrong_letters.split("").join(" ")}"
		puts
	end

	def get_guess
		if @turn < 9
			show_board
			puts "Enter your letter guess..."
			letter = gets.chomp.downcase
			if validate_letter(letter)
				check_guess(letter)
			else
				get_guess
			end
		else
			puts
			show_board
			puts "Dangit, you ran out of turns!"
			puts "The word was #{@word.join}..."
		end
	end

	def validate_letter(letter)
		if @guess.include?(letter) || @wrong_letters.include?(letter)
			puts
			puts "Oops, you guessed that letter already. Try again!"
			puts
			return false
		elsif (letter =~ /[[:alpha:]]/) != 0
			puts
			puts "Oops, you must enter a letter. Try again!"
			puts
			return false
		elsif letter.length != 1
			puts
			puts "Oops, you must enter only ONE letter. Try again!"
			puts
			return false
		else
			return true
		end
	end

	def check_guess(letter)
		@word.each_with_index do |l, i|
			if l == letter
				@guess[i] = letter
			end
		end
		if @word.join == @guess
			puts 
			show_board
			puts "You won!!"
		elsif @word.include?(letter)
			puts
			puts "You got a letter!"
			get_guess
		else
			puts 
			puts "No #{letter}'s."
			@wrong_letters.sub!("_", letter)
			@turn += 1
			get_guess
		end
	end

#	def get_guess
#		if @turn < 9
#			show_board
#			puts "Enter your letter guess..."
#			letter = gets.chomp.downcase
#			if @word.include?(letter)
#				puts
#				puts "You got a letter!"
#				@word.each_with_index do |l, i|
#					if l == letter
#						@guess[i] = letter
#					end
#				end
#				get_guess
#			else
#				puts
#				puts "Whoops, no #{letter}'s."
#				@wrong_letters << letter
#				@turn += 1
#				get_guess
#			end
#		else
#			puts 
#			puts "Dangit, you ran out of turns."
#			puts "The word was #{@word.join}"
#		end
#	end
end

game = Hangman.new