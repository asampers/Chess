
require_relative '../lib/player.rb'
require_relative '../lib/pieces.rb'
require_relative '../lib/moves.rb'
require_relative '../lib/board.rb'

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


end

class Game
  include Display
  include Pieces 
  include Moves

  attr_accessor :board, :current_player_id
  attr_reader :players, :pieces

  def initialize
    @board = Board.new
    @current_player_id = 0
    @players = [Player.new('white'), Player.new('black')]
    @pieces = create_pieces('white') + create_pieces('black')
    @board.place_initial_pieces(@pieces) 
  end

  def player_turn
    start = move_from()
    finish = move_to()
    piece_on_square(start)
    piece_on_square(finish)
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

  def piece_on_square(coordinates)
    p @pieces.select { |piece| piece.current == coordinates }
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

