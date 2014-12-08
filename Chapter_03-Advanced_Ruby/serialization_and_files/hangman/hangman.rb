require 'csv'

class Hangman

	def initialize
		# Where the saved games are
		@path = 'hangman_saves.csv'
		# @file_exists is 1 if the csv exists, otherwise it's 0
		@file_exists = File.exist?(@path) ? 1 : 0
		# Put all saved games in @data if there's a file
		read_data if @file_exists == 1
		# Checks if current game is a saved game
		@running_saved_game = nil
		puts
		puts "Welcome to hangman!"
		read_data
		if @data.length > 0
			intro
		else 
			new_game
		end
	end

	protected 

	# Put all saved games in @data if there's a file
	def read_data
		@data = []
		@data = CSV.read(@path)
	end

	# Rewrite csv with @data info (when a saved game is won, for example, we'll have to delete the completed game out of the csv. One step will delete the finished game, the next step will put the rest of the games back.)
	def over_write_data
		@data.delete_at(@running_saved_game)
		File.open(@path, 'w') do |f|
			@data.each do |d|
				f.puts "#{d[0]},#{d[1]},#{d[2]},#{d[3]}"
			end
		end
	end

	# Display intro message
	def intro
		puts "Load saved game or start a new one? Enter a number:"
		loop do
			puts "1. Start new game"
			puts "2. Load saved game"
			case gets.chomp
				when '1'
					new_game
					break
				when '2'
					get_game
					break
				else
					puts "Oops, enter one of the numbers below: "
					next
			end
		end
	end

	# Start a new game
	def new_game
		# Get the full list of words
		words = File.readlines('wordlist.txt')
		valid_words = []
		words.each do |w| 
			# Take all new lines and returns out
			w.gsub!(/\r\n/, "")
			# Word is valid if it's between 5 and 12 characters and isn't a proper noun. (no fair using names and such!) 
			valid_words << w if w.length.between?(5,12) && w[0] != w[0].upcase
		end
		# Split secret word into an array of letters
		@word = valid_words.sample.split("").to_a
		# This holds user's guess. Originally populated with "_" for each letter
		@guess = ""
		@word.length.times { @guess += "_"}
		# Holds user's wrong letters. Originally populated with 9 x "_"
		@wrong_letters = ""
		9.times { @wrong_letters += "_"}
		@turn = 0
		puts "Your task is to guess the secret word, letter by letter."
		puts "You have only 9 wrong letters before you lose, so guess carefully!"
		puts
		puts "Here is your word. Each _ is a letter."
		puts
		get_guess
	end

	# Get info from saved games and pick one
	def get_game
		if @file_exists == 1
			# If the file exists, but there are no rows in it, there are no saved games
			if @data.length == 0
				puts "Oops, you have no saved games."
				puts "Here, start a new one!"
				puts
				new_game
			else
				puts "Which game?"
				# Display each partially guessed word like: "1. _ e _ _ t"
				@data.each_with_index { |row, i| puts "#{i+1}. #{row[1].split("").join(" ")}" }
				# Get user's choice
				game = gets.chomp.to_i
				# If the user entered a number that appears on the board...
				if game.between?(1,@data.length)
					# Get all info out of chosen row
					@word = @data[game-1][0].split("").to_a
					@guess = @data[game-1][1]
					@wrong_letters = @data[game-1][2]
					@turn = @data[game-1][3].to_i
					@running_saved_game = (game - 1)
					# Get the next guess
					get_guess
				else
					puts "Not a valid choice! Pick again"
					get_game
				end
			end
		else
			puts "Oops, you have no saved games."
			puts "Here, start a new one!"
			puts
			new_game
		end
	end

	# Show guesses so far
	def show_board
		puts "You have use #{@turn} of 9 turns. Type \"save\" to save game and quit."
		show_hangman
		puts "Word:   #{@guess.split("").join(" ")}"
		puts
		puts "Misses: #{@wrong_letters.split("").join(" ")}"
		puts
	end

	def show_hangman
		if @turn == 0
			puts
		elsif @turn == 1
			puts
			puts "       "
			puts "       "
			puts "       "
			puts "       "
			puts "       "
			puts "      ┃  "
			puts "      ┃  "
			puts "      ┃  "
			puts "     ━┻━  "
		elsif @turn == 2
			puts
			puts "      ┃  "
			puts "      ┃  "
			puts "      ┃  "
			puts "      ┃  "
			puts "      ┃  "
			puts "      ┃  "
			puts "      ┃  "
			puts "      ┃  "
			puts "     ━┻━  "
		elsif @turn == 3
			puts "      ┏━━━━━┓  "
			puts "      ┃     ┃ "
			puts "      ┃   "
			puts "      ┃   "
			puts "      ┃   "
			puts "      ┃   "
			puts "      ┃   "
			puts "      ┃   "
			puts "      ┃   "
			puts "     ━┻━  "
		elsif @turn == 4
			puts "      ┏━━━━━┓  "
			puts "      ┃     ┃ "
			puts "      ┃    ╭╶╮      "
			puts "      ┃    ╰╶╯      "
			puts "      ┃          "
			puts "      ┃          "
			puts "      ┃          "
			puts "      ┃          "
			puts "      ┃          "
			puts "     ━┻━           "
		elsif @turn == 5
			puts "      ┏━━━━━┓  "
			puts "      ┃     ┃ "
			puts "      ┃    ╭╶╮      "
			puts "      ┃    ╰╶╯      "
			puts "      ┃    ╲      "
			puts "      ┃          "
			puts "      ┃          "
			puts "      ┃          "
			puts "      ┃          "
			puts "     ━┻━           "
		elsif @turn == 6
			puts "      ┏━━━━━┓  "
			puts "      ┃     ┃ "
			puts "      ┃    ╭╶╮      "
			puts "      ┃    ╰╶╯      "
			puts "      ┃    ╲ ╱     "
			puts "      ┃          "
			puts "      ┃          "
			puts "      ┃          "
			puts "      ┃          "
			puts "     ━┻━           "
		elsif @turn == 7
			puts "      ┏━━━━━┓  "
			puts "      ┃     ┃ "
			puts "      ┃    ╭╶╮      "
			puts "      ┃    ╰╶╯      "
			puts "      ┃    ╲ ╱     "
			puts "      ┃     │     "
			puts "      ┃         "
			puts "      ┃          "
			puts "      ┃          "
			puts "     ━┻━           "
		elsif @turn == 8
			puts "      ┏━━━━━┓  "
			puts "      ┃     ┃ "
			puts "      ┃    ╭╶╮      "
			puts "      ┃    ╰╶╯      "
			puts "      ┃    ╲ ╱     "
			puts "      ┃     │     "
			puts "      ┃    ╱      "
			puts "      ┃          "
			puts "      ┃          "
			puts "     ━┻━           "
		elsif @turn == 9
			puts "      ┏━━━━━┓  "
			puts "      ┃     ┃ "
			puts "      ┃    ╭╶╮      "
			puts "      ┃    ╰╶╯      "
			puts "      ┃    ╲ ╱     "
			puts "      ┃     │     "
			puts "      ┃    ╱ ╲     "
			puts "      ┃          "
			puts "      ┃          "
			puts "     ━┻━           "
		end
	end

	# Get a new letter from user
	def get_guess
		# There are turns left...
		if @turn < 9
			show_board
			puts "Enter your letter guess..."
			letter = gets.chomp.downcase
			validate_letter(letter)
		# No turns left, show losing message and delete game if it was previously saved
		else
			puts
			show_board
			puts "Dangit, you ran out of turns!"
			puts "The word was #{@word.join}..."
			if @running_saved_game != nil
				over_write_data
			end
			go_again
		end
	end

	# Make sure letter is a valid option
	def validate_letter(letter)
		# If user wants to save, save game
		if letter.downcase == "save"
			save_game
		# If letter has already been guessed (either in word or in missed letters) make another guess
		elsif @guess.include?(letter) || @wrong_letters.include?(letter)
			puts
			puts "Oops, you guessed that letter already. Try again!"
			puts
			get_guess
		# If letter is not in the alphabet
		elsif (letter =~ /[[:alpha:]]/) != 0
			puts
			puts "Oops, you must enter a letter. Try again!"
			puts
			get_guess
		# If too many letters were chosen
		elsif letter.length != 1
			puts
			puts "Oops, you must enter only ONE letter. Try again!"
			puts
			get_guess
		# All good! Check if the letter won the game
		else
			check_guess(letter)
		end
	end

	# Check if there's a win, a correct letter or a wrong letter
	def check_guess(letter)
		# If the guessed letter is in the word, replace "_" in the guess variable with the letter in the right spot
		@word.each_with_index do |l, i|
			if l == letter
				@guess[i] = letter
			end
		end
		# If the guessed word and the answer are the same, the user won!
		# Show message and if the game was previously saved, delete it
		if @word.join == @guess
			puts 
			show_board
			puts "You won!!"
			if @running_saved_game != nil
				over_write_data
			end
			go_again
		# Got a letter but didn't win. Get another guess
		elsif @word.include?(letter)
			puts
			puts "You got a letter!"
			get_guess
		# Letter wasn't in word, put letter in missed letter variable and guess again
		else
			puts 
			puts "No #{letter}'s."
			@wrong_letters.sub!("_", letter)
			@turn += 1
			get_guess
		end
	end

	def go_again
		loop do 
			puts
			puts "See definition, start a new game, load a game, or quit?"
			puts "1. See definition"
			puts "2. Start a new game or load a saved one"
			puts "3. Quit"
			option = gets.chomp
			case option
				when '1'
					system("open http://dictionary.reference.com/browse/#{@word.join}")
					intro
					break
				when '2'
					initialize
					break
				when '3'
					break
				else
					next
			end
		end
	end

	# Save the current game
	def save_game
		# If current game was previously saved, delete the old version of current game...
		if @running_saved_game != nil
			over_write_data
		end
		# And add new version of current game to saved data
		File.open(@path, 'a+') do |f|
				f.puts "#{@word.join},#{@guess},#{@wrong_letters},#{@turn}"
		end
	end

end

game = Hangman.new