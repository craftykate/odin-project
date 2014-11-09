module ConnectFour

	class Game
		attr_accessor :current_player

		def start
			puts "\nWelcome to Connect Four!\n\n"
			@player1 = Player.new(1)
			@player2 = Player.new(2)
			@current_player = @player1
			@board = Board.new
			show_status
		end

		def show_status
			puts @board.show_board
			puts "\nPlayer #{@current_player.player_number}, pick a column to drop your #{@current_player.player_color} marker in:"
		end

		def get_spot
			column = $stdin.gets.chomp
			if validate_spot(column) == true
				row = find_empty_row(column)
				if (0..5).include?(row)
					@board.modify_board(column, row, @current_player.player_piece, @current_player.player_number, @current_player.player_color)
					if @board.check_win(row, (column.to_i - 1), @current_player.player_number) == false
						if @board.check_tie == false
							switch_players
							show_status
							get_spot
						else
							puts @board.show_board
							puts "Game ended in a tie!"
							go_again?
						end
					else
						puts @board.show_board
						puts "Player #{@current_player.player_number} won!"
						go_again?
					end
				else
					puts "Oops! That column is full, pick a new one:"
					get_spot
				end
			else
				puts "Oops! You must enter anumber between 1 and 7"
				get_spot
			end
		end

		def validate_spot(column)
			column = column.to_i
			return (1..7).include?(column) ? true : false
		end

		def find_empty_row(column)
			column = column.to_i - 1
			@board.return_board.each_with_index do |row, i|
				if row[column].piece == nil
					return i
				end
			end
		end

		def switch_players
			@current_player = (@current_player.player_number == 1) ? @player2 : @player1
		end

		def go_again?
			puts "Go again? y/n"
			go_again = $stdin.gets.chomp
			if go_again.downcase == "y"
				game = Game.new
				game.start
				game.get_spot
			end
		end
	end

	class Board
		attr_accessor :board

		def initialize
			create_board
		end

		def create_board
			@board = []
			6.times do |y|
				@board[y] = []
				7.times do |x|
					@board[y][x] = Node.new
				end
			end
			@board
		end

		def modify_board(column, row, piece, player, color)
			column = (column.to_i - 1)
			@board[row][column].piece = piece
			@board[row][column].player = player
			@board[row][column].color = color
			@board
		end

		def return_board
			@board
		end

		def check_tie
			check = 0
			@board.each do |row|
				row.each do |column|
					check += 1 if column.player != nil
				end
			end
			if check == 42
				return true
			else
				return false
			end
		end

		def check_win(row, column, player_number)
			if (check_down(row, column, player_number) >= 3) || (check_right(row, column, player_number) + check_left(row, column, player_number) >= 3) || (check_up_right(row, column, player_number) + check_down_left(row, column, player_number) >= 3) || (check_up_left(row, column, player_number) + check_down_right(row, column, player_number) >= 3)
				return true
			else
				return false
			end
		end

		def check_down(row, column, player_number, amount = 0)
			if (row-1).between?(0,5) && @board[row - 1][column].player == player_number
				amount += 1
				check_down((row-1), column, player_number, amount)
			else
				return amount
			end
		end

		def check_right(row, column, player_number, amount = 0)
			if (column+1).between?(0,6) && @board[row][column + 1].player == player_number
				amount += 1
				check_right(row, (column + 1), player_number, amount)
			else
				return amount
			end
		end

		def check_left(row, column, player_number, amount = 0)
			if (column-1).between?(0,6) && @board[row][column - 1].player == player_number
				amount += 1
				check_left(row, (column - 1), player_number, amount)
			else
				return amount
			end
		end

		def check_up_right(row, column, player_number, amount = 0)
			if (row+1).between?(0,5) && (column+1).between?(0,6) && @board[row + 1][column + 1].player == player_number
				amount += 1
				check_up_right((row + 1), (column + 1), player_number, amount)
			else
				return amount
			end
		end

		def check_down_left(row, column, player_number, amount = 0)
			if (row-1).between?(0,5) && (column-1).between?(0,6) && @board[row - 1][column - 1].player == player_number
				amount += 1
				check_down_left((row - 1), (column - 1), player_number, amount)
			else
				return amount
			end
		end

		def check_up_left(row, column, player_number, amount = 0)
			if (row+1).between?(0,5) && (column-1).between?(0,6) && @board[row + 1][column - 1].player == player_number
				amount += 1
				check_up_left((row + 1), (column - 1), player_number, amount)
			else
				return amount
			end
		end

		def check_down_right(row, column, player_number, amount = 0)
			if (row-1).between?(0,5) && (column+1).between?(0,6) && @board[row - 1][column + 1].player == player_number
				amount += 1
				check_down_right((row - 1), (column + 1), player_number, amount)
			else
				return amount
			end
		end

		def show_board
			top_left = "\u250c"
			top_separator = "\u252c"
			top_right = "\u2510"
			bottom_left = "\u2514"
			bottom_separator = "\u2534"
			bottom_right = "\u2518"
			hor = "\u2500"
			side = "\u2502"
			plus = "\u253c"
			left_separator = "\u251c"
			right_separator = "\u2524"

			top_row = top_left + (hor*4 + top_separator)*6 + hor*4 + top_right
			spacer_row = left_separator + (hor*4 + plus)*6 + hor*4 + right_separator
			bottom_row = bottom_left + (hor*4 + bottom_separator)*6 + hor*4 + bottom_right

			body_rows = []
			6.times do |y|
				body_rows[y] = []
				body_rows[y] = side + 
					(@board[y][0].piece).to_s.center(4) + side + 
					(@board[y][1].piece).to_s.center(4) + side + 
					(@board[y][2].piece).to_s.center(4) + side + 
					(@board[y][3].piece).to_s.center(4) + side + 
					(@board[y][4].piece).to_s.center(4) + side + 
					(@board[y][5].piece).to_s.center(4) + side + 
					(@board[y][6].piece).to_s.center(4) + side
			end
			
			["  1    2    3    4    5    6    7", top_row, body_rows[5], spacer_row, body_rows[4], spacer_row, body_rows[3], spacer_row, body_rows[2], spacer_row, body_rows[1], spacer_row, body_rows[0], bottom_row ]
		end
	end

	class Node
		attr_accessor :color, :player, :piece

		def initialize
			@color = nil
			@player = nil
			@piece = nil
		end
	end

	class Player
		attr_accessor :player_number, :player_piece, :player_color
	
		def initialize(num)
			@player_number = num
			@player_piece = (num == 1) ? "\u26aa" : "\u26ab"
			@player_color = (num == 1) ? "white" : "black"
		end
	end
end