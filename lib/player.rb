class Player
  require_relative '../lib/game.rb'
  require_relative '../lib/pawn.rb'

  attr_accessor :game, :pieces

  def initialize(game, pieces)
    @game = game
    @pieces = pieces
    place_initial_pieces()
  end


  def place_initial_pieces()
    @pieces.each do |piece|
      x = piece.current[0]
      y = piece.current[1]
      @game.board[x][y] = piece.symbol
    end  
  end
end