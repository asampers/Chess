
require_relative '../lib/player.rb'
require_relative '../lib/pieces.rb'
require_relative '../lib/moves.rb'

module Display

  LTRS = ['a', 'b',
          'c', 'd',
          'e', 'f',
          'g', 'h']

  def adjust_player_selection(selection)
    selection[0] = 8 - selection[0].to_i
    LTRS.each_with_index do |ltr, ind| 
      selection[1] = ind if ltr == selection[1] 
    end
    selection
  end

  def place_initial_pieces()
    pieces.each do |teams|
      teams.each do |piece|
      x = piece.starting[0]
      y = piece.starting[1]
      board[x][y] = piece.symbol
      end
    end  
  end

  def print_board
    print "\e[32m   a  b  c  d  e  f  g  h\n\e[0m"
    board.each_with_index do |line, index|
      changed = line.map.each_with_index {|spot, ind| select_background(index, ind, spot) }.join
      puts "\e[34m#{(board.size) - index}\e[0m #{changed} \e[34m#{(board.size) - index}\e[0m"
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
  include Moves

  attr_accessor :board, :current_player_id
  attr_reader :players, :pieces

  def initialize
    @board = Array.new(8) { Array.new(8) }
    @current_player_id = 0
    @players = [Player.new('white'), Player.new('black')]
    @pieces = create_pieces('white'), create_pieces('black')
    place_initial_pieces() 
  end

  def move_from
    puts "Which piece would you like to move, #{current_player}?"
    start = current_player.pick_square
    adjust_player_selection(start)
  end

  def move_to
    puts "Where would you like to move it to?"
    finish = current_player.pick_square
    adjust_player_selection(finish)
  end

  def current_player
    @players[@current_player_id]
  end

  def other_player_id
    1 - @current_player_id
  end

  def opponent
    @players[other_player_id]
  end

  def switch_players!
    @current_player_id = other_player_id
  end
end

