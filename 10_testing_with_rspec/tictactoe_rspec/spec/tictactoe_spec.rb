require './lib/tictactoe'

module TicTacToe

	describe Game do

		let(:game) { Game.new }

		before(:each) do 
			allow(game).to receive(:puts)
			allow(game).to receive(:print)
		end
		
		describe "#start" do

			it "puts a welcome message" do 
				expect(game).to receive(:puts).with('Welcome to Tic Tac Toe!')
				game.start
			end

			it "sets first player to player 1" do 
				game.start
				expect(game.current_player.player_number).to be == 1
			end
		end

		describe "#assign_player" do 

			before do 
				game.start
				@player = Player.new(1)
				@player2 = Player.new(2)
				@player_2_to_1 = game.assign_player(2)
				@player_1_to_2 = game.assign_player(1)
			end

			it "assigns the next player" do 
				expect(@player_2_to_1.player_number).to be == 1
				expect(@player_1_to_2.player_number).to be == 2
			end
		end

		describe "#validate_answer" do 

			context "user enters a valid number" do 

				it "accepts a number 1 - 9" do
					expect(game.validate_answer("1")).to be_truthy
				end
			end

			context "user enters a wrong form of input" do

				it "doesn't allow a zero" do 
					expect(game.validate_answer("0")).to be_falsey
				end
				it "doesn't allow a higher number" do 
					expect(game.validate_answer("10")).to be_falsey
				end
				it "doesn't allow a non-number" do 
					expect(game.validate_answer("d")).to be_falsey
				end
			end
		end
 	end

 	describe Player do 

		it "give players correct attributes" do 
			player1 = Player.new(1)
			player2 = Player.new(2)
			expect(player1.player_number).to be == (1)
			expect(player1.player_piece).to be == ("X")
			expect(player2.player_number).to be == (2)
			expect(player2.player_piece).to be == ("O")
		end
	end

	describe Board do 

		let(:the_board) { Board.new }

		describe "#create_board" do 

			it "creates an empty board" do 
				the_board
				expect(the_board.create_board).to match_array(["1:  ", "2:  ", "3:  ", "4:  ", "5:  ", "6:  ", "7:  ", "8:  ", "9:  "])
			end
		end

		describe "#modify_board" do 

			it "adds marker to board" do 
				the_board
				expect(the_board.modify_board(5, "X")).to match_array(["1:  ", "2:  ", "3:  ", "4:  ", "5: X", "6:  ", "7:  ", "8:  ", "9:  "])
			end
		end

		describe "#check_tie" do 

			context "game has not ended in a tie" do 

				it "doesn't say there's a tie" do 
				the_board.board = ["1: X", "2: O", "3: X", "4:  ", "5: X", "6:  ", "7:  ", "8: O", "9:  "]
				expect(the_board.check_tie).to be_falsey
				end
			end

			context "game has ended in a tie" do 

				it "says there's a tie" do 
				the_board.board = ["1: O", "2: X", "3: X", "4: X", "5: X", "6: O", "7: O", "8: O", "9: X"]
				expect(the_board.check_tie).to be_truthy
				end
			end
		end

		describe "#check_win" do 

			it "displays winning message across top" do 
				the_board.board = ["1: X", "2: X", "3: X", "4:  ", "5: X", "6:  ", "7:  ", "8: O", "9:  "]
				expect(the_board.check_win("X")).to be_truthy
			end
			it "displays winning message across middle" do 
				the_board.board = ["1:X", "2: ", "3: ", "4: O", "5: O", "6: O", "7:  ", "8:  ", "9: O"]
				expect(the_board.check_win("O")).to be_truthy
			end
			it "displays winning message across bottom" do 
				the_board.board = ["1: ", "2: ", "3: ", "4: X", "5: X", "6: X", "7: X", "8:  ", "9: O"]
				expect(the_board.check_win("X")).to be_truthy
			end
			it "displays winning message down left" do 
				the_board.board = ["1: O", "2:O", "3: ", "4: O", "5:  ", "6: X", "7: O", "8:  ", "9:  "]
				expect(the_board.check_win("O")).to be_truthy
			end
			it "displays winning message down middle" do 
				the_board.board = ["1: O", "2: X", "3:  ", "4:  ", "5: X", "6:  ", "7:  ", "8: X", "9: X"]
				expect(the_board.check_win("X")).to be_truthy
			end
			it "displays winning message down right" do 
				the_board.board = ["1:  ", "2:  ", "3: X", "4:  ", "5:  ", "6: X", "7:  ", "8:  ", "9: X"]
				expect(the_board.check_win("X")).to be_truthy
			end
			it "displays winning message horizontally from 1" do 
				the_board.board = ["1: O", "2: X", "3:  ", "4:  ", "5: O", "6:  ", "7:  ", "8:  ", "9: O"]
				expect(the_board.check_win("O")).to be_truthy
			end
			it "displays winning message horizontally from 7" do 
				the_board.board = ["1:  ", "2:  ", "3: X", "4:  ", "5: X", "6: ", "7: X", "8:  ", "9:  "]
				expect(the_board.check_win("X")).to be_truthy
			end
		end

		describe "#return_board" do 

			it "returns an array of the current board" do 
				expect(the_board.return_board).to match_array(["1:  ", "2:  ", "3:  ", "4:  ", "5:  ", "6:  ", "7:  ", "8:  ", "9:  "])
			end
		end
	end
end