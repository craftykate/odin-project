class Mastermind

	def initialize
		puts " "
		@answer = []
		4.times { @answer << rand(6) + 1 }
		@board = []
		@evaluate = []
		@turn = 0
		puts "Welcome to Mastermind!"
		puts "The computer has made a secret code using the numbers 1-6"
		puts "in four spots like this: \"5136\""
		puts "Your task is to guess the order!"
		puts "You have 12 tries to get it right."
		puts 
		puts "You will be told how many numbers are in the right spot"
		puts "Like this: \"2 right\""
		puts "And how many numbers are in the secret code, but need to be moved"
		puts "Like this: \"1 close\""
		puts
		puts "So if the secret code is 1231 and you enter 2136, the output will be"
		puts "\"1 right, 2 close\" since the 3 is right and the 2 and 1 need to be moved" 
		guess_again
	end

	protected

	def guess_again(message = nil)
		if @turn < 12
			if message == nil
				show_board
			end
			puts 
			puts "Enter your guess. You've used #{@turn} of 12 turns."
			guess = gets.chomp
			arr = []
			guess.split("").each { |num| arr << num.to_i }
			sanitize_input(arr)
		else
			puts 
			puts "Whoops! You ran out of turns"
			puts "The correct answer was #{@answer.join}"
		end
	end

	def show_board
		if !@board.empty?
			puts 
			puts "-------------------"
			puts "Board so far: "
			@board.each_with_index do |guess, i| 
				puts "#{guess.join} #{@evaluate[i]}"
			end
			puts "-------------------"
		end
	end

	def sanitize_input(arr)
		checking = 0
		message = nil
		arr.each do |n|
			unless (1..6).include?(n)
				checking += 1
			end
		end
		if checking == 0 && arr.length == 4
			@board << arr
			@turn += 1
			check_guess(arr)
		elsif checking == 0 && arr.length != 4
			message = "Whoops! You must enter exactly FOUR numbers like this: 3241"
			error(message)
		elsif checking > 0 && arr.length == 4
			message = "Whoops! You must enter numbers 1-6 like this: 4256"
			error(message)
		else
			message = "Whoops! You must enter FOUR numbers and they have to be 1-6 \nlike this: 1234"
			error(message)
		end
	end

	def error(message)
		puts
		puts message
		guess_again("err")
	end

	def check_guess(arr)
		if arr == @answer
			puts "Congrats, you won!"
			puts "You guessed the code of #{@answer.join} in #{@turn} turns!"
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
			next_num = 0
			4.times do |x|
				if temp_guess[x] == num && next_num == 0
					almost_guesses += 1
					temp_guess[x] = 9
					temp_answer[i] = 8
					next_num = 1
				end
			end
		end
		@evaluate << "#{right_guesses} right, #{almost_guesses} close"
		guess_again
	end
end

game = Mastermind.new