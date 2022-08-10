
require_relative '../lib/player.rb'
require_relative '../lib/pieces.rb'
require_relative '../lib/move.rb'
require_relative '../lib/move_long.rb'
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
  include Move
  include MoveLong

  attr_accessor :board, :current_player_id
  attr_reader :players, :pieces

  def initialize
    @board = Board.new
    @current_player_id = 0
    @players = [Player.new('white'), Player.new('black')]
    @pieces = create_pieces('white') + create_pieces('black')
    @board.place_pieces(@pieces) 
  end

  def play
    player_turn()
    switch_players!()
    player_turn()
  end


  def player_turn
    start = move_from()
    selected_piece = piece_on_square(start).pop
    finish = move_to(selected_piece)
    final_square = piece_on_square(finish).pop

    p moves = selected_piece.possible_moves
    p path = find_path(moves, finish)

    selected_piece.move(finish) if moves.include?(finish) #&& clear_path?(path)
    
    @pieces.delete(final_square) 
    
    @board.clear_space(start)
    @board.clear_space(finish) 
    @board.place_pieces(@pieces)
    @board.display
  end

  def move_from
    puts "Which piece would you like to move, #{current_player}?"
    start = current_player.pick_square
    adjust_player_selection(start)
  end

  def move_to(selected_piece)
    puts "Where would you like to move your #{selected_piece}?"
    finish = current_player.pick_square
    adjust_player_selection(finish)
  end

  def piece_on_square(coordinates)
    @pieces.select { |piece| piece.current == coordinates }
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

