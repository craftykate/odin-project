require 'yaml'

module Chess

	class Game
		attr_accessor :current_player

		def initialize
			@turn = 0
			# go to start
 		end

		# Welcome message, create board
		def start
			puts "\nWelcome to Chess!"
			puts "\nINSTRUCTIONS: To move a piece: type coordinates, row first then column,"
			puts "of the piece you want to move and where you want to move to,"
			puts "like this: \"2d to 4d\""
			puts "The \"to\" is optional. \"2d 4d\" and \"2d4d\" work as well."
			puts "To save a game just type save"
			create_board
			# go to get_names
		end

		# Determines if a game has been saved and if player wants to load it
		def load_or_new
			game_data = YAML::load_file('chess_save.yaml')
			# Only if there's data in there...
			unless game_data.class == FalseClass
				@player1 = game_data[0]
				@player2 = game_data[1]
				@current_player = game_data[2]
				@turn = game_data[3]
				@board = game_data[4]
				puts "Here is your current game board:"
				puts show_board
				puts "\nDo you want to continue your saved game? y/n"
				# Loop until user inputs a valid response
				loop do
					answer = $stdin.gets.chomp
					# Load saved game
					if answer[0].downcase == "y"
						show_status
						get_spot
						break
					# Erase saved game and start a new game
					elsif answer[0].downcase == "n"
						File.open('chess_save.yaml', 'w') { }
						@turn = 0
						create_board
						get_names
						show_status
						get_spot
						break
					else
						puts "Sorry, I didn't understand that. Put a y or an n: "
					end
				end
			end
		end

		# Save the game
		def save_game
			# Put all needed data into an array
			data = []
			data[0] = @player1
			data[1] = @player2
			data[2] = @current_player
			data[3] = @turn
			data[4] = @board
			# Dup data into yaml variable
			game_yaml = YAML::dump(data)
			# Write yaml variable into save file
			File.open('chess_save.yaml', 'w') { |f| f.write game_yaml }
			puts "Game is saved! Have a nice day."
			exit
		end

		# Create's the game board
		def create_board
			# Set up board of empty nodes
			@board = []
			8.times do |y|
				@board[y] = []
				8.times do |x|
					@board[y][x] = Node.new
				end
			end
			# Set white pieces in nodes
			white_pieces = ["\u265c", "\u265e", "\u265d", "\u265b", "\u265a", "\u265d", "\u265e", "\u265c"]
			names = ["rook", "knight", "bishop", "queen", "king", "bishop", "knight", "rook"]
			8.times do |x|
				@board[0][x].chess_piece = white_pieces[x]
				@board[0][x].chess_color = "white"
				@board[0][x].chess_name = names[x]
			end
			8.times do |x|
				@board[1][x].chess_piece = "\u265f"
				@board[1][x].chess_color = "white"
				@board[1][x].chess_name = "pawn"
			end
			# Set black pieces in nodes
			black_pieces = ["\u2656", "\u2658", "\u2657", "\u2655",  "\u2654", "\u2657", "\u2658", "\u2656"]
 			8.times do |x|
				@board[7][x].chess_piece = black_pieces[x]
				@board[7][x].chess_color = "black"
				@board[7][x].chess_name = names[x]
			end
			8.times do |x|
				@board[6][x].chess_piece = "\u2659"
				@board[6][x].chess_color = "black"
				@board[6][x].chess_name = "pawn"
			end
			@board
		end

		# Get names, Create new players, Set player names
		def get_names
			puts "\nPlayer 1 (white), what is your name?"
			player1 = $stdin.gets.chomp
			puts "\nPlayer 2 (black), what is your name?"
			player2 = $stdin.gets.chomp
			set_players(player1, player2)
			# go to show_status
		end

		# Method to create new players
		def set_players(name1, name2)
			@player1 = Player.new(name1, 1)
			@player2 = Player.new(name2, 2)
			@current_player = @player1
		end

		# Switch players
		def switch_players
			@current_player = (@current_player.player_number == 1) ? @player2 : @player1
		end

		# Check if player is in check, Show board
		def show_status
			check_if_check
			puts show_board
			if @in_check != true 
				if check_if_stale_or_mate
					File.open('chess_save.yaml', 'w') { }
					go_again?("#{@current_player.player_name} is stalemated! Sorry, you lose.")
				end
			end
			if @in_check 
				if check_if_stale_or_mate
					File.open('chess_save.yaml', 'w') { }
					go_again?("#{@current_player.player_name} has been mated! Sorry, you lose.")
				end
			end
			check_if_check
			puts "You are in check! Your next move MUST get you out of check." if @in_check == true
			print "\n#{@current_player.player_name} (#{@current_player.player_color}) enter your move: "
			# go to get_spot
		end

		# Show the current state of the board 
		def show_board
			top_left, top, top_separator, top_right, side, left_plus, right_plus, plus, bottom_left, bottom_separator, bottom_right = "\u250c", "\u2500", "\u252c", "\u2510", "\u2502", "\u251c", "\u2524", "\u253c", "\u2514", "\u2534", "\u2518"

			top_row = top_left + (top*3 + top_separator)*7 + top*3 + top_right
			spacer_row = left_plus + (top*3 + plus)*7 + top*3 + right_plus
			bottom_row = bottom_left + (top*3 + bottom_separator)*7 + top*3 + bottom_right

			body_rows = []
			8.times do |y|
				body_rows[y] = []
				body_rows[y] = "#{y + 1} " + side + 
					(@board[y][0].chess_piece).to_s.center(3) + side +
					(@board[y][1].chess_piece).to_s.center(3) + side +
					(@board[y][2].chess_piece).to_s.center(3) + side +
					(@board[y][3].chess_piece).to_s.center(3) + side +
					(@board[y][4].chess_piece).to_s.center(3) + side +
					(@board[y][5].chess_piece).to_s.center(3) + side +
					(@board[y][6].chess_piece).to_s.center(3) + side +
					(@board[y][7].chess_piece).to_s.center(3) + side 
			end

			# Return final board
			[" ", "    a   b   c   d   e   f   g   h", "  " + top_row, body_rows[7], "  " + spacer_row, body_rows[6], "  " + spacer_row, body_rows[5], "  " + spacer_row, body_rows[4], "  " + spacer_row, body_rows[3], "  " + spacer_row, body_rows[2], "  " + spacer_row, body_rows[1], "  " + spacer_row, body_rows[0], "  " + bottom_row ]
		end

		# Check if player is in check
		def check_if_check
			king_position = []
			enemy_position = []
			@in_check = false	
			# Go through each row in board
			@board.each_with_index do |row, row_index|
				# Go through each piece in row
				row.each_with_index do |piece, column|
					# If the piece is the player's king
					if piece.chess_name == "king" && piece.chess_color == @current_player.player_color
						# Store king's position
						king_position = [row_index, column]
					end
					# Collect each enemy's position
					if piece.chess_name != nil && piece.chess_color != @current_player.player_color
						enemy_position << [row_index, column]
					end
				end
			end
			# Go through each enemy's piece and see if they can move to the king's spot
			enemy_position.each do |enemy|
				@in_check = true if validate_move(enemy[0], enemy[1], king_position[0], king_position[1])
			end
			@in_check
		end

		def check_if_stale_or_mate
			player_pieces = []
			stale_or_mate = true
			opposite_color = (@current_player.player_color == "white") ? "black" : "white"
			# Go through each row in board
			@board.each_with_index do |row, row_index|
				# Go through each piece in row
				row.each_with_index do |piece, column|
					if piece.chess_name != nil && piece.chess_color == @current_player.player_color 
						player_pieces << [row_index, column]
					end
				end
			end
			temp_board = YAML::dump(@board)
			player_pieces.each do |player_move|
				legal_moves = []
				# If it's a pawn, get the legal pawn moves
				if @board[player_move[0]][player_move[1]].chess_name == "pawn"
					legal_moves << get_legal_pawn(opposite_color, @board[player_move[0]][player_move[1]].first_move, player_move[0], player_move[1]) 
				end
				# If it's a knight get the legal knight moves (lol - "knight moves")
				if @board[player_move[0]][player_move[1]].chess_name == "knight"
					movements = [ [2,1], [1,2], [-1,2], [-2,1], [-2,-1], [-1,-2], [1,-2], [2,-1] ]
					legal_moves << get_legal_knight(opposite_color, player_move[0], player_move[1], movements)
				end
				# If it's a king get the legal king moves
				if @board[player_move[0]][player_move[1]].chess_name == "king"
					movements = [ [1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1]]
					legal_moves << get_legal_king(opposite_color, player_move[0], player_move[1], movements)
				end
				# horizontal and vertical moves
				if @board[player_move[0]][player_move[1]].chess_name == "rook" || @board[player_move[0]][player_move[1]].chess_name == "queen"
					movements = [ [1,0], [0,1], [-1,0], [0,-1] ]
					movements.each do |move|
						legal_moves << get_legal(opposite_color, player_move[0], move[0], player_move[1], move[1])
					end
				end
				# diagonal moves
				if @board[player_move[0]][player_move[1]].chess_name == "queen" || @board[player_move[0]][player_move[1]].chess_name == "bishop"
					movements = [ [1,1], [-1,1], [-1,-1], [1,-1] ]
					movements.each do |move|
						legal_moves << get_legal(opposite_color, player_move[0], move[0], player_move[1], move[1])
					end
				end
				legal_moves.each do |moves|
					moves.each do |move|
						@board[move[0]][move[1]] = @board[player_move[0]][player_move[1]]
						@board[player_move[0]][player_move[1]] = Node.new
						check_if_check
						stale_or_mate = false if @in_check == false
						@board = YAML::load(temp_board)
						return false if stale_or_mate == false
					end
				end
			end
			return true
		end

		# Get the player's next move
		def get_spot
			input = $stdin.gets.chomp
			save_game if input.downcase == "save"
			# Separate out coordinates
			from_row, from_column = get_coordinates(input[0], input[1])
			to_row, to_column = get_coordinates(input[-2], input[-1])
			# Check if coordinates are valid
			if check_if_coordinates_are_valid(from_row, from_column, to_row, to_column)
				# Check if player owns the piece
				if check_owner(from_row, from_column, @current_player.player_color)
					# Check if piece can make that move 
					if validate_move(from_row, from_column, to_row, to_column)
						# Store the board in a temporary variable in case move results in a check and needs to be undone
						temp_board = YAML::dump(@board)
						# If player is in check...
						if @in_check
							# Move the piece
							modify_board(from_row, from_column, to_row, to_column)
							check_if_check
							if @in_check
								print_error("You didn't get out of check! ", false)
								@turn -= 1
								@board = YAML::load(temp_board)
								get_spot
							end
						else
							# Move the piece
							modify_board(from_row, from_column, to_row, to_column)
							check_if_check
							if @in_check
								print_error("You can't move there, it will put you in check! ", false)
								@turn -= 1
								@board = YAML::load(temp_board)
								@in_check = false
								get_spot
							end
						end
						# Switch players
						switch_players
						# Show board (which checks if next player is in check)
						show_status
						# Get the player's move and start over
						get_spot
					# Invalid move for piece
					else
						print_error("Your piece can't move there.", true)
						get_spot
					end
				# Player doens't own the piece
				else
					print_error("That's not your piece or the space you chose is empty.", true)
					get_spot
				end
			# Coordinates aren't valid
			else
 				print_error("One of your choices is not a valid space on the board.", true)
 				get_spot
 			end
		end

		# Print error message details
		def print_error(msg, syntax)
			print "\nInvalid entry! "
			puts msg
			puts "Remember the syntax is like this: 2d to 4d. \n" if syntax == true
			puts "Save a game by typing \"save\""
			print "Pick again: "
		end

		# Start game over again
		def go_again?(msg)
			puts msg
			puts "Go again? y/n"
			go_again = $stdin.gets.chomp
			if go_again.downcase == "y"
				Game.new
				start
				load_or_new
				get_names
				show_status
				get_spot
			else
				exit
			end
		end

		# Turn player's coordinates into position in array
		def get_coordinates(y, x)
			row = y.to_i - 1
			row = (0..7).include?(row) ? row : false
			columns = {"a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5, "g" => 6, "h" => 7}
			column = ("a".."h").include?(x) ? columns[x] : false
			[row, column]
		end

		# Checks if coordinates are valid
		def check_if_coordinates_are_valid(from_row, from_column, to_row, to_column)
			return ([from_row, from_column, to_row, to_column].none? { |i| i == false}) ? true : false
		end

		# Check if player owns the piece they are trying to move
		def check_owner(from_row, from_column, player_color)
			return (@board[from_row][from_column].chess_color == player_color) ? true : false 
		end

		# Make sure piece can move to the new spot legally
		def validate_move(from_row, from_column, to_row, to_column)
			# Store the piece to be moved
			piece = @board[from_row][from_column]
			# Store the opposite color of the piece to be moved
			opposite_color = (piece.chess_color == "white") ? "black" : "white"
			# Set up empty array for all the piece's legal moves
			legal_moves = []
			# If it's a pawn, get the legal pawn moves
			if piece.chess_name == "pawn"
				legal_moves << get_legal_pawn(opposite_color, piece.first_move, from_row, from_column) 
			end
			# If it's a knight get the legal knight moves (lol - "knight moves")
			if piece.chess_name == "knight"
				movements = [ [2,1], [1,2], [-1,2], [-2,1], [-2,-1], [-1,-2], [1,-2], [2,-1] ]
				legal_moves << get_legal_knight(opposite_color, from_row, from_column, movements)
			end
			# If it's a king get the legal king moves
			if piece.chess_name == "king"
				movements = [ [1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1]]
				legal_moves << get_legal_king(opposite_color, from_row, from_column, movements)
			end
			# horizontal and vertical moves
			if piece.chess_name == "rook" || piece.chess_name == "queen"
				movements = [ [1,0], [0,1], [-1,0], [0,-1] ]
				movements.each do |move|
					legal_moves << get_legal(opposite_color, from_row, move[0], from_column, move[1])
				end
			end
			# diagonal moves
			if piece.chess_name == "queen" || piece.chess_name == "bishop"
				movements = [ [1,1], [-1,1], [-1,-1], [1,-1] ]
				movements.each do |move|
					legal_moves << get_legal(opposite_color, from_row, move[0], from_column, move[1])
				end
			end
			return (legal_moves.any? { |move| move.include?([to_row, to_column]) }) ? true : false
		end

		# Get legal pawn moves
		def get_legal_pawn(opposite_color, first_move, from_row, from_column, legal_moves = [])
			# Store which rows piece can jump to
			jump_row_1 = (opposite_color == "black") ? (from_row + 1) : (from_row - 1)
			jump_row_2 = (opposite_color == "black") ? (from_row + 2) : (from_row - 2)
			# Forward one space
			if jump_row_1.between?(0,7)
				move = @board[jump_row_1][from_column]
				# If space is empty, pawn can move there
				if move.chess_piece == nil
					legal_moves << [jump_row_1, from_column]
					# Forward two spaces
					if jump_row_2.between?(0,7)
						move = @board[jump_row_2][from_column]
						# If space is empty, pawn can move there - if that piece hasn't moved yet
						if move.chess_piece == nil
							legal_moves << [jump_row_2, from_column] if first_move == 0
						end
					end
				end
			end
			# Sideways to attack
			movements = [1,-1]
			movements.each do |movement|
				if (from_column + movement).between?(0,7)
					move = @board[jump_row_1][from_column + movement]
					if move.chess_color == opposite_color
						legal_moves << [jump_row_1, from_column + movement]
					end
				end
			end
			# En-passant
			this_piece = @board[from_row][from_column]
			if this_piece.en_passant_turn == @turn
				if this_piece.en_passant_direction == "up"
					(this_piece.chess_color == "white") ? legal_moves << [from_row + 1, from_column + 1] : legal_moves << [from_row - 1, from_column + 1]
				elsif this_piece.en_passant_direction == "down"
					(this_piece.chess_color == "white") ? legal_moves << [from_row + 1, from_column - 1] : legal_moves << [from_row - 1, from_column - 1]
				end
			end
 			legal_moves
		end

		# Make a pawn ready to make an en passant move
		def en_passant_ready(color, to_row, to_column)
			# spot_array = [[-1, left_spot, "up"], [1, right_spot, "down"]]
			if (to_column - 1).between?(0,7)
				left_spot = @board[to_row][to_column - 1]
				if left_spot.chess_name == "pawn" && left_spot.chess_color != color
					left_spot.en_passant_turn = @turn
					left_spot.en_passant_direction = "up"
				end
			end
			if (to_column + 1).between?(0,7)
				right_spot = @board[to_row][to_column + 1]
				if right_spot.chess_name == "pawn" && right_spot.chess_color != color
					right_spot.en_passant_turn = @turn
					right_spot.en_passant_direction = "down"
				end
			end
		end

		# Clear the spot taken by an en passant move
		def en_passant_move(color, to_row, to_column)
			if color == "white"
				@board[to_row - 1][to_column] = Node.new
			else
				@board[to_row + 1][to_column] = Node.new
			end
		end

		# Get legal knight moves
		def get_legal_knight(opposite_color, from_row, from_column, movements, legal_moves = [])
			movements.each do |move|
				if (from_row + move[0]).between?(0,7) && (from_column + move[1]).between?(0,7)
					piece = @board[from_row + move[0]][from_column + move[1]]
					if piece.chess_color == nil || piece.chess_color == opposite_color
						legal_moves << [(from_row + move[0]), (from_column + move[1])]
					end
				end
			end
			legal_moves
		end

		# Get legal king moves
		def get_legal_king(opposite_color, from_row, from_column, movemets, legal_moves = [])
			movemets.each do |move|
				if (from_row + move[0]).between?(0,7) && (from_column + move[1]).between?(0,7)
					piece = @board[from_row + move[0]][from_column + move[1]]
					if piece.chess_color == nil || piece.chess_color == opposite_color
						legal_moves << [(from_row + move[0]), (from_column + move[1])]
					end
				end
			end
			# Castling
			# Position of king
			this_piece = @board[from_row][from_column]
			# If king hasn't moved yet and isn't in check
			if this_piece.first_move == 0 && @in_check == false
				# Position of each king's rook
				left_rook, right_rook = ((this_piece.chess_color == "white") ? @board[0][0] : @board[7][0]), ((this_piece.chess_color == "white") ? @board[0][7] : @board[7][7])
				rooks = [left_rook, right_rook]
				# Where each king wants to jump to
				left_jump, right_jump = ((this_piece.chess_color == "white") ? [0, 2] : [7, 2]), ((this_piece.chess_color == "white") ? [0, 6] : [7, 6])
				king_jumps = [left_jump, right_jump]
				# Position of each empty space to check for emptiness
				left_1, left_2, left_3 = (from_column - 1), (from_column - 2), (from_column - 3)
				right_1, right_2 = (from_column + 1), (from_column + 2)
				rook_spaces = [[left_1, left_2, left_3], [right_1, right_2]]
				empty_space = [[from_row, (from_column - 1)], [from_row, (from_column + 1)]]
				# Go through each of the king's rooks
				rooks.each_with_index do |rook, rook_index|
					# If the rook hasn't moved yet
					if rook.first_move == 0
						# If each space between king and rook is empty
						if @board[from_row][(rook_spaces[rook_index][0])].chess_piece == nil && @board[from_row][(rook_spaces[rook_index][1])].chess_piece == nil && (rook_index == 1 || @board[from_row][(rook_spaces[rook_index][2])].chess_piece == nil)
							# Checking variable set to zero
							check_castle = 0
							# Go through each row on the board
							@board.each_with_index do |row, row_index|
								# Go through each piece in each row
								row.each_with_index do |piece, column|
									# If the piece is an enemy piece 
									if piece.chess_color != this_piece.chess_color 
										# If the piece isn't a pawn and it can move to one of the empty spaces
										if piece.chess_name != "pawn" && validate_move(row_index, column, empty_space[rook_index][0], empty_space[rook_index][1])
											# Increase checking variable
											check_castle += 1
										end
										# If the piece is a pawn
										if piece.chess_name == "pawn"
											# If pawn can attack empty space diagonally
											if (rook_index == 0 && (column == 2 || column == 4)) || (rook_index == 1 && (column == 4 || column == 6))
												# If pawn is in the correct row
												check_castle += 1 if (piece.chess_color == "white" && row_index == 5) || (piece.chess_color == "black" && row_index == 1)
											end
										end
									end
								end
							end
							# If checking variable is still zero the king can move towards the rook, so add that jump into legal_moves
							legal_moves << king_jumps[rook_index] if check_castle == 0
						end
					end
				end
			end
			legal_moves
		end

		# for pieces that can go several spaces in each direction: bishop, queen, rook
		def get_legal(opposite_color, from_row, row_adjust, from_column, column_adjust, legal_moves = [])
			if (from_row + row_adjust).between?(0,7) && (from_column + column_adjust).between?(0,7)
				# Store the spot to be moved to
				piece = @board[from_row + row_adjust][from_column + column_adjust]
				# If that spot is empty or of an opposite color...
				if piece.chess_color == nil || piece.chess_color == opposite_color
					# Store the move as legal
					legal_moves << [(from_row + row_adjust), (from_column + column_adjust)]
					# If the spot is empty, keep checking along that line to see where else it can land
					if piece.chess_color == nil
						get_legal(opposite_color, (from_row + row_adjust), row_adjust, (from_column + column_adjust), column_adjust, legal_moves)
					end
				end
			end
			legal_moves
		end

		# Promote a pawn
		def promote_pawn(piece, to_row, to_column)
			white_pieces = ["\u265c", "\u265e", "\u265d", "\u265b", "\u265a", "\u265d", "\u265e", "\u265c"]
			black_pieces = ["\u2656", "\u2658", "\u2657", "\u2655",  "\u2654", "\u2657", "\u2658", "\u2656"]
			names = ["rook", "knight", "bishop", "queen", "king", "bishop", "knight", "rook"]
			puts "Promote your pawn!"
			# Cycle through the valid names
			0.upto(3) do |i|
				puts "#{i + 1}: #{names[i].capitalize}"
			end
			# Get the piece the player wants to promote to
			print "Type the number of the piece you want to turn your pawn into: "
			answer = $stdin.gets.chomp
			# If it's a valid answer turn the pawn into the new piece
			if (1..4).include?(answer.to_i)
				choice = answer.to_i - 1
				@board[to_row][to_column].chess_color = piece.chess_color
				@board[to_row][to_column].chess_name = names[choice]
				@board[to_row][to_column].chess_piece = (piece.chess_color == "white") ? white_pieces[choice] : black_pieces[choice]
				@board[to_row][to_column]
			# Not a valid answer so get another answer from the player
			else
				puts "Oops, invalid choice, choose again."
				promote_pawn(piece, to_row, to_column)
			end
		end

		# Move the piece
		def modify_board(from_row, from_column, to_row, to_column, move = 1)
			# Increase the number of turns of the game (this keeps track of whether en passant can happen on the very next turn)
			@turn += 1
			# Store the piece to be moved
			piece = @board[from_row][from_column]
			# Store which row the pawn would have to move to the be promoted
			promote_row = (piece.chess_color == "white") ? 7 : 0
			# Increase that piece's move
			piece.first_move += move
			# Create an empty node where the piece moved from
			@board[from_row][from_column] = Node.new
			# If piece is a pawn and it has reached the final row...
			if piece.chess_name == "pawn" && to_row == promote_row
				# Promote the pawn
				promote_pawn(piece, to_row, to_column) 
			# If the piece is a pawn and it has jumped 2 rows...
			elsif piece.chess_name == "pawn" && (to_row - from_row).abs == 2
				# Move the piece and...
				@board[to_row][to_column] = piece
				# Make the piece en passant ready
				en_passant_ready(piece.chess_color, to_row, to_column)
			# If the piece is a pawn and it has made an en passant move (gone sideways on an empty spot)...
			elsif piece.chess_name == "pawn" && (to_row - from_row).abs == 1 && (to_column - from_column).abs == 1 && @board[to_row][to_column].chess_name == nil
				# Move the piece and...
				@board[to_row][to_column] = piece
				# Remove the piece it attacked
				en_passant_move(piece.chess_color, to_row, to_column)
			# If the piece is a king and it has moved two spaces it just castled so...
			elsif piece.chess_name == "king" && (from_column - to_column).abs == 2
				# Move the piece and move the corresponding rook
				@board[to_row][to_column] = piece
				if to_column == 2
					if to_row == 7
						modify_board(7, 0, 7, 3)
					elsif to_row == 0
						modify_board(0, 0, 0, 3)
					end
				elsif to_column == 6
					if to_row == 7
						modify_board(7, 7, 7, 5)
					elsif to_row == 0
						modify_board(0, 7, 0, 5)
					end
				end
			# The piece wasn't a pawn or a castling king so just move it
			else
				@board[to_row][to_column] = piece
			end
		end
	end

	# Set up each chess piece as an empty Node
	class Node
		attr_accessor :chess_piece, :chess_color, :chess_name, :first_move, :en_passant, :en_passant_turn, :en_passant_direction
	
		def initialize
			@chess_piece = nil
			@chess_color = nil
			@chess_name = nil
			@first_move = 0
			@en_passant = false
			@en_passant_turn = 0
			@en_passant_direction = nil
		end
	end

	# Set up info for each player
	class Player
		attr_accessor :player_name, :player_number, :player_color
	
		def initialize(name, num)
			@player_name = name
			@player_number = num
			@player_color = (num == 1) ? "white" : "black"
		end
	end
end