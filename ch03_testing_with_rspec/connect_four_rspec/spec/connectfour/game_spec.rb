require './lib/connectfour.rb'

module ConnectFour 

	describe Game do 

		let(:game) { Game.new }

		before(:each) do 
			allow(game).to receive(:puts)
			allow(game).to receive(:print)
		end

		describe "#start" do 

			it "puts a welcome message" do 
				expect(game).to receive(:puts).with("\nWelcome to Connect Four!\n\n")
				game.start
			end

			it "shows an empty board" do 
				expect(game).to receive(:puts).with([
					"  1    2    3    4    5    6    7", 
					"┌────┬────┬────┬────┬────┬────┬────┐", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"└────┴────┴────┴────┴────┴────┴────┘"
				])
				game.start
			end

			it "sets first player to player 1" do
				game.start
				expect(game.current_player.player_number).to be == 1
				expect(game.current_player.player_piece).to be == "\u26aa"
				expect(game.current_player.player_color).to be == "white"
			end
		end

		describe "#show_status" do

			it "shows instructions" do 
				game.start
				expect(game).to receive(:puts).with("\nPlayer 1, pick a column to drop your white marker in:")
				game.show_status
			end
		end

		describe "#validate_spot" do
			
			context "user enters a valid number" do 

				it "accepts a number 1 - 7" do 
					expect(game.validate_spot("1")).to be_truthy
				end
			end

			context "user enters an invalid entry" do 

				it "doesn't accept zero" do 
					expect(game.validate_spot("0")).to be_falsey
				end
				it "doesn't accept a higher number" do 
					expect(game.validate_spot("12")).to be_falsey
				end
				it "doesn't accept a letter" do 
					expect(game.validate_spot("f")).to be_falsey
				end
				it "doesn't accept another character" do 
					expect(game.validate_spot("[")).to be_falsey
				end
			end
		end
		
		describe "#switch_players" do
			
			it "switches players" do 
				game.start
				expect(game.switch_players.player_number).to be == 2
			end
		end
	end

	describe Board do

		let(:board) { Board.new }

		describe "#create_board" do

			it "creates a board with 6 rows of 7 items" do 
				board
				expect(board.create_board.length).to be == 6
				expect(board.create_board[0].length).to be == 7
			end
		end		

		describe "#modify_board" do
			
			it "allows user to place marker" do 
				board
				board.modify_board(6, 0, "\u26aa", 1, "white")
				expect(board.show_board).to match_array([
					"  1    2    3    4    5    6    7", 
					"┌────┬────┬────┬────┬────┬────┬────┐", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │ \u26aa  │    │", 
					"└────┴────┴────┴────┴────┴────┴────┘"
				])
			end
		end

		describe "#check_win" do

			it "successfully sees a win up and down" do 
				board.board[0][0].player = 1
				board.board[1][0].player = 1
				board.board[2][0].player = 1
				board.board[3][0].player = 1
				expect(board.check_win(3, 0, 1)).to be_truthy
			end 
			it "successfully sees a win side to side" do 
				board.board[0][1].player = 1
				board.board[0][2].player = 1
				board.board[0][3].player = 1
				board.board[0][4].player = 1
				board.board[0][5].player = 1
				expect(board.check_win(0, 3, 1)).to be_truthy
			end 
			it "successfully sees a win horizontally - bottom left to top right" do 
				board.board[0][1].player = 1
				board.board[1][2].player = 1
				board.board[2][3].player = 1
				board.board[3][4].player = 1
				board.board[4][5].player = 1
				expect(board.check_win(2, 3, 1)).to be_truthy
			end 
			it "successfully sees a win horizontally - top left to bottom right" do 
				board.board[5][1].player = 1
				board.board[4][2].player = 1
				board.board[3][3].player = 1
				board.board[2][4].player = 1
				board.board[1][5].player = 1
				expect(board.check_win(3, 3, 1)).to be_truthy
			end 
		end

		describe "#check_tie" do
			before do 
				board
				6.times do |y|
					7.times do |x|
						board.board[y][x].player = 1
					end
				end
			end
			it "successfully checks if there's a tie" do 
				expect(board.check_tie).to be_truthy
			end 
		end

		describe "#show_board" do

			it "shows an empty board" do 
				board
				expect(board.show_board).to match_array([
					"  1    2    3    4    5    6    7", 
					"┌────┬────┬────┬────┬────┬────┬────┐", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"├────┼────┼────┼────┼────┼────┼────┤", 
					"│    │    │    │    │    │    │    │", 
					"└────┴────┴────┴────┴────┴────┴────┘"
				])
				board.show_board
			end
		end
	end

	describe Player do

		it "gives players correct attributes" do 
			player1 = Player.new(1)
			player2 = Player.new(2)
			expect(player1.player_number).to be == 1
			expect(player1.player_piece).to be == "\u26aa"
			expect(player1.player_color).to be == "white"
			expect(player2.player_number).to be == 2
			expect(player2.player_piece).to be == "\u26ab"
			expect(player2.player_color).to be == "black"
		end
	end

	describe Node do

		it "creates an instance of Node with all nil attributes" do 
			node = Node.new
			expect(node).to be_a Node
			expect(node.color).to be == nil
			expect(node.player).to be == nil
			expect(node.piece).to be == nil
		end
	end
end