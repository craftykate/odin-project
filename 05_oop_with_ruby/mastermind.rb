class Mastermind

	def initialize
		puts " "
		@answer = []
		4.times { @answer << rand(6) + 1 }
		@board = []
		@evaluate = []
		@turn = 0
		puts "Welcome to Mastermind!"
		puts "The computer has made a code using the numbers 1-6"
		puts "in four spots like this:"
		puts "\"5136\""
		puts "Your task is to guess the order!"
		guess_again
	end

	protected

	def guess_again
		if @turn < 12
			show_board
			if @turn != 0
				puts "You've used #{@turn} of 12 turns."
			end
			puts "Enter your guess"
			guess = gets.chomp
			arr = []
			guess.split("").each { |num| arr << num.to_i }
			if sanitize_input(arr) == 1
				@board << arr
				@turn += 1
				check_guess(arr)
			elsif sanitize_input(arr) == 2
				puts "!!!!"
				puts "Whoops! You must enter exactly FOUR numbers like this: 3241"
				puts "!!!!"
				guess_again
			else
				puts "!!!!"
				puts "Whoops! You must enter numbers 1-6 like this: 4256"
				puts "!!!!"
				guess_again
			end
		else
			puts "Whoops! You ran out of turns"
			puts "The correct answer was #{@answer.join}"
		end
	end

	def show_board
		if !@board.empty?
			puts "Board so far: "
			@board.each_with_index do |guess, i| 
				puts "#{guess.join} #{@evaluate[i]}"
			end
		end
	end

	def sanitize_input(arr)
		checking = 0
		arr.each do |n|
			unless (1..6).include?(n)
				checking += 1
			end
		end
		if checking == 0 && arr.length == 4
			return 1
		elsif checking == 0 && arr.length != 4
			return 2
		else
			return 3
		end
	end

	def check_guess(arr)
		if arr == @answer
			puts "you won!"
		else
			evaluate_guess
		end
	end

	def evaluate_guess
		right_guesses = 0
		almost_guesses = 0
		temp_answer = []
		temp_guess = []
		@answer.each { |n| temp_answer << n }
		@board[-1].each { |n| temp_guess << n }
		temp_answer.each_with_index do |num, i|
			if temp_guess[i] == num
				right_guesses += 1
				temp_guess[i] = 9
				temp_answer[i] = 8
			end
		end
		temp_answer.each_with_index do |num, i|
			4.times do |x|
				if temp_guess[x] == num
					almost_guesses += 1
					temp_guess[x] = 9
					temp_answer[i] = 8
				end
			end
		end
		@evaluate << "#{right_guesses} right, #{almost_guesses} close"
		guess_again
	end
end

game = Mastermind.new