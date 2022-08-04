
require_relative '../lib/player.rb'
require_relative '../lib/pieces.rb'


module Display

  def print_board
    print "\e[32m   a  b  c  d  e  f  g  h\n\e[0m"
    @board.each_with_index do |line, index|
      changed = line.map.each_with_index {|spot, ind| select_background(index, ind, spot) }.join
      puts "\e[34m#{(@board.size) - index}\e[0m #{changed} \e[34m#{(@board.size) - index}\e[0m"
    end
    puts "\e[32m   a  b  c  d  e  f  g  h\n\e[0m"
  end

  def select_background(row_index, column_index, spot)
    if spot.nil?
      (row_index + column_index).even? ? "\e[46m   \e[0m" : "\e[44m   \e[0m" 
    else
      (row_index + column_index).even? ? "\e[46m #{spot} \e[0m" : "\e[44m #{spot} \e[0m"  
    end   
  end
end

class Game
  include Display
  include Pieces 

  attr_accessor :board, :players, :pieces

  def initialize
    @board = Array.new(8) { Array.new(8) }
    @players = [Player.new('white'), Player.new('black')]
    @pieces = create_pieces('white'), create_pieces('black')
    place_pieces() 
  end


  def place_pieces()
    @pieces.each do |teams|
      teams.each do |piece|
      x = piece.starting[0]
      y = piece.starting[1]
      @board[x][y] = piece.symbol
      end
    end  
  end
end