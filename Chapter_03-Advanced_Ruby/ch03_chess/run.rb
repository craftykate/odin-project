require './lib/chess.rb'

game = Chess::Game.new
game.start
game.load_or_new
game.get_names
game.show_status
game.get_spot