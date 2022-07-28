class Player
  require_relative '../lib/game.rb'
  require_relative '../lib/pawn.rb'

  attr_accessor :game, :pieces

  def initialize(game, starting_location)
    @game = game
    @starting_location = starting_location
    @pieces = Pawn.new(starting_location, 0), Pawn.new(starting_location, 1), Pawn.new(starting_location, 2), Pawn.new(starting_location, 3)
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