class TicTacToe

	def initialize
		# Set up board with empty spaces
		@board = []
		i = 1
		9.times do  
			@board << "#{i}:  "
			i += 1
		end 
		puts "Welcome to Tic Tac Toe!"
		@turn = 1
		# Start choosing a spot
		choose_spot
	end

	protected

	def choose_spot
		# Show the current board 
		show_board
		# Define who the player is and what their game piece is
		@player = @turn.odd? ? "1" : "2"
		@board_piece = @turn.odd? ? "X" : "O"
		# Let player choose a spot
		puts "Player #{@player} (#{@board_piece}): Your turn. Type a number to put your #{@board_piece} in the spot."
		# Check whether spot is valid
		check_valid_spot

	end

	def show_board
		puts "----------------"
		puts "|#{@board[0]}|#{@board[1]}|#{@board[2]}|"
		puts "|----|----|----|"
		puts "|#{@board[3]}|#{@board[4]}|#{@board[5]}|"
		puts "|----|----|----|"
		puts "|#{@board[6]}|#{@board[7]}|#{@board[8]}|"
		puts "----------------"
	end

	def check_valid_spot
		loop do 
			spot = gets.chomp.to_i
			# If user entered a number 1-9
			if (1..9).include?(spot) 
				# And that board spot is empty
				if @board[spot-1][-1] == " "
					# Let user put their board piece in that spot
					enter_move(spot)
					break
				else
					# Someone has a piece in that spot, choose again
					puts "Whoops, there's a game piece in that spot already. Choose an empty spot."
				end
			else
				# User didn't enter a valid number, choose again
				puts "Whoops, not a valid spot. Pick a number 1 to 9." 
			end
		end	
	end

	def enter_move(spot)
		# Put player's board piece in the spot they chose
		@board[spot-1][-1] = @board_piece
		# Check if the user won
		if check_win ==  1
			show_board
			# If they won, stop the game
			puts "The #{@board_piece}'s have it! Player #{@player} won!"
		elsif check_win == 2
			show_board
			# If the board is full and no winner, stop the game
			puts "Game over! It's a tie :("
			puts "Play again?"
		else
			# If no winner yet and board isn't full...
			# Move on to next player
			@turn += 1
			# Let that player choose a spot
			choose_spot
		end
	end

	def check_win
		winning_numbers = [ [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6] ]
		check_win_array = []
		board_full = 0
		@board.each_with_index do |spot, i|
			check_win_array << i if spot.include?(@board_piece)
			board_full += 1 if spot.include?("X") || spot.include?("O")
		end
		won = 0
		winning_numbers.each do |arr_wins|
			check_arr = 0
			arr_wins.each do |spot|
				if check_win_array.include?(spot)
					check_arr += 1
				end
				won = 1 if check_arr == 3
			end
		end
		if won == 1
			return 1
		elsif board_full == 9
			return 2
		end
	end

end

game = TicTacToe.new
