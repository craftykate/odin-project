require 'csv'

class Hangman

	def initialize
		@path = 'hangman_saves.csv'
		@running_saved_game = nil
		puts
		puts "Welcome to hangman!"
		intro
	end

	protected 

	def intro
		puts "Load saved game or start a new one?"
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

	def new_game
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
		puts "Your task is to guess the secret word, letter by letter."
		puts "You have only 9 wrong letters before you lose, so guess carefully!"
		puts
		puts "Here is your word. Each _ is a letter."
		puts
		get_guess
	end

	def get_game
		data = []
		if File.exist?(@path)
			data = CSV.read(@path)
			if data.length == 0
				puts "Oops, you have no saved games."
				puts "Here, start a new one!"
				puts
				new_game
			else
				puts "Which game?"
				data.each_with_index { |row, i| puts "#{i+1}. #{row[1].split("").join(" ")}" }
				game = gets.chomp.to_i
				if game.between?(1,data.length)
					@word = data[game-1][0].split("").to_a
					@guess = data[game-1][1]
					@wrong_letters = data[game-1][2]
					@turn = data[game-1][3].to_i
					@running_saved_game = (game - 1)
					get_guess
				else
					puts "Not a valid choice! Pick again"
					get_game
				end
			end
		else
			puts "Oops, you have no saved games."
			puts "Here, start a new one!"
			new_game
		end
	end

	def show_board
		puts "You have use #{@turn} of 9 turns. Type \"save\" to save game and quit."
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
			validate_letter(letter)
		else
			puts
			show_board
			puts "Dangit, you ran out of turns!"
			puts "The word was #{@word.join}..."
			if @running_saved_game != nil
				data = []
				data = CSV.read(@path)
				data.delete_at(@running_saved_game)
			File.open(@path, 'w') do |f|
				data.each do |d|
					f.puts "#{d[0]},#{d[1]},#{d[2]},#{d[3]}"
				end
			end
			end
		end
	end

	def validate_letter(letter)
		if letter.downcase == "save"
			save_game
		elsif @guess.include?(letter) || @wrong_letters.include?(letter)
			puts
			puts "Oops, you guessed that letter already. Try again!"
			puts
			get_guess
		elsif (letter =~ /[[:alpha:]]/) != 0
			puts
			puts "Oops, you must enter a letter. Try again!"
			puts
			get_guess
		elsif letter.length != 1
			puts
			puts "Oops, you must enter only ONE letter. Try again!"
			puts
			get_guess
		else
			check_guess(letter)
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
			if @running_saved_game != nil
				data = []
				data = CSV.read(@path)
				data.delete_at(@running_saved_game)
				File.open(@path, 'w') do |f|
					data.each do |d|
						f.puts "#{d[0]},#{d[1]},#{d[2]},#{d[3]}"
					end
				end
			end
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

	def save_game
		if @running_saved_game != nil
			data = []
			data = CSV.read(@path)
			data.delete_at(@running_saved_game)
			File.open(@path, 'w') do |f|
				data.each do |d|
					f.puts "#{d[0]},#{d[1]},#{d[2]},#{d[3]}"
				end
			end
		end
		File.open(@path, 'a+') do |f|
				f.puts "#{@word.join},#{@guess},#{@wrong_letters},#{@turn}"
		end
	end

end

game = Hangman.new