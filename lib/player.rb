class Player
  require_relative '../lib/game.rb'
  require_relative '../lib/moves.rb' 

  attr_accessor :game, :pieces

  def initialize(game, pieces)
    @game = game
    @pieces = pieces
    #place_initial_pieces()
  end


  def place_initial_pieces()
    @pieces.each do |piece|
      x = piece.starting[0]
      y = piece.starting[1]
      @game.board[x][y] = piece.symbol
    end  
  end

  def pick_square
    puts "Which piece would you like to move?"
    loop do
      print "Enter letter and number of square: "
      selection = gets.chomp.downcase
      return selection if selection.match(/[a-h][1-8]/)
      puts "Please enter letters 'a-h' and numbers '1-8' without space inbetween."
    end  
  end
end