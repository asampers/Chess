require_relative './lib/game.rb'
require_relative './lib/player.rb'
require_relative './lib/pawn.rb'
require_relative './lib/bishop.rb'
require_relative './lib/king.rb'
require_relative './lib/knight.rb'
require_relative './lib/queen.rb'
require_relative './lib/rook.rb'


game = Game.new
p game.players[0].pieces.size
game.print_board