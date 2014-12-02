require './lib/chess'
require 'stringio'

module Chess
	
	describe Game do
		
		let(:game) { Game.new }

		before(:each) do 
			allow(game).to receive(:puts)
			allow(game).to receive(:print)
		end

		describe "#start" do

			it "prints welcome message" do 
				expect(game).to receive(:puts).with("\nINSTRUCTIONS: To move a piece: type coordinates, row first then column,")
				game.start
			end 
		end

		describe "#create_board" do
			
			it "creates a board of 8 rows of 8 items" do 
				expect(game.create_board.length).to be == 8
				expect(game.create_board[0].length).to be == 8
			end 

			it "sets the 1a item to a white rook" do
				expect(game.create_board[0][0].chess_color).to be == "white"
				expect(game.create_board[0][0].chess_piece).to be == "\u265c"
				expect(game.create_board[0][0].chess_name).to be == "rook"
				expect(game.create_board[0][0].first_move).to be == 0
			end

			it "sets the 8e item to a black king" do
				expect(game.create_board[7][4].chess_color).to be == "black"
				expect(game.create_board[7][4].chess_piece).to be == "\u2654"
				expect(game.create_board[7][4].chess_name).to be == "king"
				expect(game.create_board[7][4].first_move).to be == 0
			end
		end

		describe "#set_players" do
			
			it "sets first player to player 1" do 
				game.set_players("Kate", "Jack")
				expect(game.current_player.player_number).to be == 1
				expect(game.current_player.player_name).to be == "Kate"
				expect(game.current_player.player_color).to be == "white"
			end 
		end

		describe "#switch_players" do
			
			it "can switch players" do 
				game.set_players("Kate", "Jack")
				# Switch from 1 to 2
				expect(game.switch_players.player_number).to be == 2
				# Switch from 2 to 1
				expect(game.switch_players.player_name).to be == "Kate"
				# Switch from 1 to 2
				expect(game.switch_players.player_color).to be == "black"
			end 
		end

		describe "#show_board" do
			
			it "shows the starting board with pieces in the right spot" do 
				game.create_board
				expect(game.show_board).to match_array([
					" ",
					"    a   b   c   d   e   f   g   h",
					"  ┌───┬───┬───┬───┬───┬───┬───┬───┐",
					"8 │ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"7 │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"6 │   │   │   │   │   │   │   │   │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"5 │   │   │   │   │   │   │   │   │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"4 │   │   │   │   │   │   │   │   │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"3 │   │   │   │   │   │   │   │   │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"2 │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"1 │ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │",
					"  └───┴───┴───┴───┴───┴───┴───┴───┘"
				])
			end 
		end

		describe "#check_if_check" do
			
			before(:each) do 
				game.create_board
				game.set_players("Kate", "Jack")
			end

			it "doesn't show check with a new board" do 
				expect(game.check_if_check).to be_falsey
			end 

			it "shows check when King is in check" do 
				game.modify_board(0, 3, 2, 4)
				game.modify_board(6, 4, 5, 0)
				game.switch_players
				expect(game.check_if_check).to be_truthy
			end
		end

		describe "#get_coordinates" do

			before(:each) do 
				game
			end
			
			it "gets the proper coordinates" do 
				expect(game.get_coordinates("2", "d")).to be == [1, 3]
			end 

			it "returns false when row is invalid" do
				expect(game.get_coordinates("0", "d")).to be == [false, 3]
			end

			it "returns false when row is a letter" do
				expect(game.get_coordinates("e", "d")).to be == [false, 3]
			end

			it "returns false when column is invalid" do
				expect(game.get_coordinates("2", "k")).to be == [1, false]
			end

			it "returns false when column is a number" do
				expect(game.get_coordinates("2", "3")).to be == [1, false]
			end
		end

		describe "#check_owner" do

			before(:each) do 
				game.start
			end
			
			it "makes sure current player owns the piece s/he's trying to move" do 
				expect(game.check_owner(1, 3, "white")).to be_truthy
			end 

			it "won't move a piece the player doesn't own" do 
				expect(game.check_owner(1, 3, "black")).to be_falsey
			end 
		end

		describe "#validate_move" do

			before(:each) do 
				game
				game.create_board
				game.set_players("Kate", "Jack")
			end

			context "for a pawn" do 

				context "no piece is in the way" do 

					it "returns true if jumps forward two spaces on first move" do 
						expect(game.validate_move(1, 3, 3, 3)).to be_truthy
						expect(game.validate_move(6, 4, 4, 4)).to be_truthy
						expect(game.validate_move(1, 7, 3, 7)).to be_truthy
					end

					it "returns false if it jumps forward two spaces on the second move" do
						game.modify_board(1, 3, 2, 3)
						expect(game.validate_move(2, 3, 4, 3)).to be_falsey
						game.modify_board(6, 4, 5, 4)
						expect(game.validate_move(5, 4, 3, 4)).to be_falsey
					end

					it "returns true if jumps forward one space" do 
						game.modify_board(1, 3, 3, 3)
						expect(game.validate_move(3, 3, 4, 3)).to be_truthy
					end
				end

				context "a piece is in the way" do

					it "returns false if jumps forward two spaces" do 
						game.modify_board(6, 3, 2, 3)
						expect(game.validate_move(1, 3, 3, 3)).to be_falsey
						game.modify_board(6, 5, 3, 5)
						expect(game.validate_move(1, 5, 3, 5)).to be_falsey
					end

					it "returns false if jumps forward one space" do 
						game.modify_board(6, 1, 2, 1)
						expect(game.validate_move(1, 1, 2, 1)).to be_falsey
					end
				end

				it "returns true if it goes diagonal and captures a piece" do 
					game.modify_board(6, 3, 2, 3)
					expect(game.validate_move(1, 4, 2, 3)).to be_truthy
				end

				it "returns false if it goes diagonal and doesn't capture a piece" do 
					expect(game.validate_move(6, 4, 5, 5)).to be_falsey
					expect(game.validate_move(1, 4, 2, 3)).to be_falsey
				end

				it "returns false if it goes diagonal and its own color is in the spot" do 
					game.modify_board(6, 2, 5, 2)
					expect(game.validate_move(6, 1, 5, 2)).to be_falsey
				end

				it "can't go backwards" do 
					game.modify_board(6, 6, 4, 6)
					expect(game.validate_move(4, 6, 5, 6)).to be_falsey
					game.modify_board(1, 1, 2, 1)
					expect(game.validate_move(2, 1, 1, 1)).to be_falsey
				end

				it "can't go three spaces" do 
					expect(game.validate_move(1, 1, 4, 1)).to be_falsey
				end

				it "can't go sideways" do 
					game.modify_board(6, 3, 4, 3)
					expect(game.validate_move(4, 3, 4, 4)).to be_falsey
				end

				context	"en-passant" do 

					it "white can take a pawn en-passant on the next move" do 
						game.modify_board(1, 3, 4, 3)
						game.modify_board(6, 4, 4, 4)
						expect(game.validate_move(4, 3, 5, 4)).to be_truthy
						game.modify_board(4, 3, 5, 4)
						expect(game.show_board).to match_array([
							" ",
							"    a   b   c   d   e   f   g   h",
							"  ┌───┬───┬───┬───┬───┬───┬───┬───┐",
							"8 │ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"7 │ ♙ │ ♙ │ ♙ │ ♙ │   │ ♙ │ ♙ │ ♙ │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"6 │   │   │   │   │ ♟ │   │   │   │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"5 │   │   │   │   │   │   │   │   │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"4 │   │   │   │   │   │   │   │   │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"3 │   │   │   │   │   │   │   │   │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"2 │ ♟ │ ♟ │ ♟ │   │ ♟ │ ♟ │ ♟ │ ♟ │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"1 │ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │",
							"  └───┴───┴───┴───┴───┴───┴───┴───┘"
						])
					end

					it "black can take a pawn en-passant on the next move" do 
						game.modify_board(1, 0, 2, 0)
						game.modify_board(6, 3, 3, 3)
						game.modify_board(1, 2, 3, 2)
						expect(game.validate_move(3, 3, 2, 2)).to be_truthy
						game.modify_board(3, 3, 2, 2)
						expect(game.show_board).to match_array([
							" ",
							"    a   b   c   d   e   f   g   h",
							"  ┌───┬───┬───┬───┬───┬───┬───┬───┐",
							"8 │ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"7 │ ♙ │ ♙ │ ♙ │   │ ♙ │ ♙ │ ♙ │ ♙ │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"6 │   │   │   │   │   │   │   │   │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"5 │   │   │   │   │   │   │   │   │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"4 │   │   │   │   │   │   │   │   │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"3 │ ♟ │   │ ♙ │   │   │   │   │   │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"2 │   │ ♟ │   │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │",
							"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
							"1 │ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │",
							"  └───┴───┴───┴───┴───┴───┴───┴───┘"
						])
					end

					it "white can't take a pawn after the next turn" do 
 						game.modify_board(1, 3, 4, 3)
						game.modify_board(6, 4, 4, 4)
						game.modify_board(1, 0, 2, 0)
						game.modify_board(6, 0, 5, 0)
						expect(game.validate_move(4, 3, 5, 4)).to be_falsey
					end
				end
			end

			context "for a rook" do 

				context "no piece is in the way" do 

					context "it lands on an empty space" do 

						it "can move forward" do 
							game.modify_board(1, 7, 2, 0)
							expect(game.validate_move(0, 7, 5, 7)).to be_truthy
							game.modify_board(6, 0, 2, 7)
							expect(game.validate_move(7, 0, 2, 0)).to be_truthy
						end

						it "can move backwards" do
							game.modify_board(0, 0, 5, 4)
							expect(game.validate_move(5, 4, 2, 4)).to be_truthy
							game.modify_board(7, 7, 2, 4)
							expect(game.validate_move(2, 4, 5, 4)).to be_truthy
						end 

						it "can move right" do 
							game.modify_board(0, 0, 3, 5)
							expect(game.validate_move(3, 5, 3, 7)).to be_truthy
							game.modify_board(7, 7, 4, 0)
							expect(game.validate_move(4, 0, 4, 7)).to be_truthy
						end 

						it "can move left" do 
							game.modify_board(0, 0, 3, 5)
							expect(game.validate_move(3, 5, 3, 0)).to be_truthy
							game.modify_board(7, 7, 4, 2)
							expect(game.validate_move(4, 2, 4, 0)).to be_truthy
						end 
					end

					context "it lands on an opponent" do 

						it "can move forward" do 
							game.modify_board(0, 0, 2, 3)
							expect(game.validate_move(2, 3, 6, 3)).to be_truthy
							game.modify_board(7, 0, 4, 2)
							expect(game.validate_move(4, 2, 1, 2)).to be_truthy
						end

						it "can move right" do
							game.modify_board(6, 6, 4, 6)
							game.modify_board(0, 0, 4, 0)
							expect(game.validate_move(4, 0, 4, 6)).to be_truthy
							game.modify_board(1, 5, 3, 5)
							game.modify_board(7, 7, 3, 0)
							expect(game.validate_move(3, 0, 3, 5)).to be_truthy
						end
					end

					context "it lands on its own color" do 

						it "can't move forward" do 
							expect(game.validate_move(0, 0, 1, 0)).to be_falsey
						end

						it "can't move right" do 
							expect(game.validate_move(7, 0, 7, 1)).to be_falsey
						end
					end
				end

				context "a piece is in the way" do 

					it "can't move backwards" do 
						game.modify_board(6, 3, 3, 2)
						game.modify_board(0, 0, 5, 2)
						expect(game.validate_move(5, 2, 2, 2)).to be_falsey
					end

					it "can't move left" do 
						game.modify_board(1, 1, 4, 4)
						game.modify_board(7, 0, 4, 5)
						expect(game.validate_move(4, 5, 4, 1)).to be_falsey
					end
				end

				it "can't go diagonal" do 
					game.modify_board(7, 7, 5, 0)
					expect(game.validate_move(5, 0, 4, 1)).to be_falsey
				end
			end

			context "for a queen" do 

				before :each do 
					game.modify_board(0, 3, 3, 3)
				end

				it "can move up" do 
					expect(game.validate_move(3, 3, 5, 3)).to be_truthy
				end

				it "can move up to the right" do
					expect(game.validate_move(3, 3, 5, 5)).to be_truthy
				end

				it "can move right" do 
					expect(game.validate_move(3, 3, 3, 7)).to be_truthy
				end

				it "can move down to the right" do 
					expect(game.validate_move(3, 3, 2, 4)).to be_truthy
				end

				it "can move down" do 
					expect(game.validate_move(3, 3, 2, 3)).to be_truthy
				end

				it "can move down to the left" do 
					expect(game.validate_move(3, 3, 2, 2)).to be_truthy
				end

				it "can move left" do 
					expect(game.validate_move(3, 3, 3, 0)).to be_truthy
				end

				it "can move up to the left" do 
					expect(game.validate_move(3, 3, 5, 1)).to be_truthy
				end
			end

			context "for a bishop" do 

				before :each do
					game.modify_board(0, 2, 3, 5)
				end

				it "can't go up" do 
					expect(game.validate_move(3, 5, 5, 5)).to be_falsey
				end

				it "can go up to the right" do 
					expect(game.validate_move(3, 5, 5, 7)).to be_truthy
				end

				it "can't go right" do 
					expect(game.validate_move(3, 5, 3, 7)).to be_falsey
				end

				it "can go down to the right" do 
					expect(game.validate_move(3, 5, 2, 6)).to be_truthy
				end

				it "can't go down" do 
					expect(game.validate_move(3, 5, 2, 5)).to be_falsey
				end

				it "can go down to the left" do 
					expect(game.validate_move(3, 5, 2, 4)).to be_truthy
				end

				it "can't go left" do 
					expect(game.validate_move(3, 5, 3, 0)).to be_falsey
				end

				it "can go up to the left" do 
					expect(game.validate_move(3, 5, 5, 3)).to be_truthy
				end
			end

			context "for a knight" do 

				before :each do 
					game.modify_board(0, 1, 4, 3)
				end

				it "can go up to the right" do 
					expect(game.validate_move(4, 3, 6, 4)).to be_truthy
				end

				it "can go to the right and up" do 
					expect(game.validate_move(4, 3, 5, 5)).to be_truthy
				end

				it "can go to the right and down" do 
					expect(game.validate_move(4, 3, 3, 5)).to be_truthy
				end

				it "can go down to the right" do 
					expect(game.validate_move(4, 3, 2, 4)).to be_truthy
				end

				it "can go down to the left" do 
					expect(game.validate_move(4, 3, 2, 2)).to be_truthy
				end

				it "can go to the left and down" do 
					expect(game.validate_move(4, 3, 3, 1)).to be_truthy
				end

				it "can go to the left and up" do 
					expect(game.validate_move(4, 3, 5, 1)).to be_truthy
				end

				it "can go up to the left" do 
					expect(game.validate_move(4, 3, 6, 2)).to be_truthy
				end

				it "can't go right" do 
					expect(game.validate_move(4, 3, 4, 7)).to be_falsey
				end

				it "can't go up" do 
					expect(game.validate_move(4, 3, 5, 3)).to be_falsey
				end
			end

			context "for a king" do 

				it "can go up" do 
					game.modify_board(0, 4, 5, 3)
					expect(game.validate_move(5, 3, 6, 3)).to be_truthy
				end

				it "can go right" do 
					game.modify_board(0, 4, 5, 3)
					expect(game.validate_move(5, 3, 5, 4)).to be_truthy
				end

				it "can go down to the right" do 
					game.modify_board(0, 4, 5, 3)
					expect(game.validate_move(5, 3, 4, 4)).to be_truthy
				end

				it "can go up to the left" do 
					game.modify_board(0, 4, 5, 3)
					expect(game.validate_move(5, 3, 6, 2)).to be_truthy
				end

				it "can't go two spaces" do 
					game.modify_board(0, 4, 5, 3)
					expect(game.validate_move(5, 3, 5, 5)).to be_falsey
				end
			end
		end

		describe "#modify_board" do

			before do
				$stdin = StringIO.new("1")
				game.create_board
			end

			after do 
				$stdin = STDIN 
			end
			
			it "moves a chess piece" do 
				game.modify_board(1, 3, 3, 3)
				expect(game.show_board).to match_array([
					" ",
					"    a   b   c   d   e   f   g   h",
					"  ┌───┬───┬───┬───┬───┬───┬───┬───┐",
					"8 │ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"7 │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"6 │   │   │   │   │   │   │   │   │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"5 │   │   │   │   │   │   │   │   │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"4 │   │   │   │ ♟ │   │   │   │   │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"3 │   │   │   │   │   │   │   │   │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"2 │ ♟ │ ♟ │ ♟ │   │ ♟ │ ♟ │ ♟ │ ♟ │",
					"  ├───┼───┼───┼───┼───┼───┼───┼───┤",
					"1 │ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │",
					"  └───┴───┴───┴───┴───┴───┴───┴───┘"
				])
			end 

			it "promotes a pawn" do 
				expect(game).to receive(:puts).with("Promote your pawn!")
				game.modify_board(1, 0, 7, 0)
			end
		end
	end

	describe Player do
		
		describe "#initialize" do

			it "gives players correct attributes" do 
				player1 = Player.new("George", 1)
				player2 = Player.new("Frank", 2)
				expect(player1.player_name).to be == "George"
				expect(player1.player_number).to be == 1
				expect(player1.player_color).to be == "white"
				expect(player2.player_name).to be == "Frank"
				expect(player2.player_number).to be == 2
				expect(player2.player_color).to be == "black"
			end 
		end
	end

	describe Node do
		
		describe "#initialize" do
			
			it "creates an instance of Node with correct attributes" do 
				node = Node.new
				expect(node).to be_a Node
				expect(node.chess_piece).to be == nil
				expect(node.chess_color).to be == nil
				expect(node.chess_name).to be == nil
				expect(node.first_move).to be == 0
				expect(node.en_passant).to be == false
				expect(node.en_passant_turn).to be == 0
			end 
		end
	end
end