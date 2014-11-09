module TicTacToe

	class Game 
		attr_accessor :current_player

		def initialize
		end

		def start
			puts 'Welcome to Tic Tac Toe!'
			@the_board = Board.new
			@player1 = Player.new(1)
			@player2 = Player.new(2)
			@current_player = @player1
			show_status
		end

		def show_status
			puts "Player #{@current_player.player_number} (#{@current_player.player_piece}): Your turn. Type a number to put your #{@current_player.player_piece} in the spot:"
			puts @the_board.show_board
		end

		def get_spot
			@answer = $stdin.gets.chomp
			if validate_answer(@answer) == true
				check_spot(@answer)
			else
				puts "Oops! You must enter a number between 1 and 9"
				get_spot
			end
		end

		def validate_answer(answer)
			if (1..9).include?(answer.to_i)
				return true
			else
				return false
			end
		end

		def check_spot(spot)
			spot = spot.to_i
			if @the_board.return_board[spot - 1][-1] == " "
				mark_spot
				if @the_board.check_tie == true
					puts "The game ended in a tie!"
					go_again?
				else
					if @the_board.check_win(@current_player.player_piece) == true
						show_win
					else
						assign_player(@current_player.player_number)
						show_status
						get_spot
					end
				end
			else
				puts "That spot has been chosen! Pick again Player #{@current_player.player_number}"
				get_spot
			end
		end

		def show_win
			puts @the_board.show_board
			puts "Player #{@current_player.player_number} won!"
			go_again?
		end

		def go_again?
			puts "Go again? y/n"
			go_again = $stdin.gets.chomp
			if go_again.downcase == "y"
				game = Game.new
				game.start
				game.get_spot
				game.mark_spot
			end
		end

		def mark_spot
			@the_board.modify_board(@answer, @current_player.player_piece)
		end

		def assign_player(num)
			@current_player = @player1 if num == 2
			@current_player = @player2 if num == 1
			@current_player
		end
	end

	class Board
		attr_accessor :board

		def initialize
			create_board
			@wins = [ [1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7] ]
		end

		def create_board
			@board = []
			(1..9).each { |i| @board << "#{i}:  " }
			@board
		end

		def return_board
			@board
		end

		def modify_board(num, marker)
			num = num.to_i
			@board[num - 1][-1] =  marker
			@board
		end

		def check_tie
			count = @board.select { |spot| spot[-1] != " " }
			if count.count == 9
				return true
			else
				return false
			end
		end

		def check_win(piece)
			@user_spots = []
			@board.select do |spot|
				@user_spots << spot[0].to_i if spot[-1] == piece
			end
			if check_against_wins == true
				return true
			else
				return false
			end
		end

		def check_against_wins
			@wins.each do |win|
				return true if win.all? { |spot| @user_spots.include?(spot) }
			end
		end
		
		def show_board
			up = "\u2502"
			over = "\u2500"
			plus = "\u253c"
			[ " ",
				@board[0] + up + @board[1] + up + @board[2], 
				over*4 + plus + over*4 + plus + over*4, 
				@board[3] + up + @board[4] + up + @board[5],
				over*4 + plus + over*4 + plus + over*4, 
				@board[6] + up + @board[7] + up + @board[8],
				" " 
			]
		end
	end

	class Player
		attr_accessor :player_number, :player_piece
	
		def initialize(num)
			@player_number = num
			@player_piece = "X" if num == 1
			@player_piece = "O" if num == 2
		end
	end
end