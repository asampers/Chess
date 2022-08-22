
require_relative '../lib/player.rb'
require_relative '../lib/pieces.rb'
require_relative '../lib/move.rb'
require_relative '../lib/check.rb'
require_relative '../lib/board.rb'
require_relative '../lib/save_game.rb'
require 'yaml'

module Display

  LTRS = ['a', 'b',
          'c', 'd',
          'e', 'f',
          'g', 'h']

  def adjust_player_selection(selection)
    return selection if selection == 'save' || selection == 'draw'
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
  include Check
  include SaveGame

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
    loop do 
      @board.display
    
      break if player_turn() == 'stop' 

      switch_players!()
    end
  end


  def player_turn
    return 'stop' if checkmate_stalemate(opponent) == 'stop'
    p "Your king is in check!" if king_in_check?() 
    loop do

      start = move_from() 
      
      return save_game(self) if start == 'save'
      return drawn_game() if start == 'draw'

      selected_piece = piece_on_square(start)

      finish = move_to(selected_piece)
      final_square = piece_on_square(finish)
      
      break if castling(selected_piece, finish)

      p moves = selected_piece.possible_moves
      p path = find_path(moves, finish)

      if selected_piece.can_move?(path, moves, finish, @board) && out_of_check(finish) && not_your_piece(finish)
        selected_piece.move(finish) 
        @pieces.delete(final_square) 
        @board.recognize_move(start, finish, @pieces)
        break
      end 
      puts "-- That's not a legal move, please select again. --" 
    end  
  end

  def move_from()
    puts "Which piece would you like to move, #{current_player}?"
    loop do 
      start = adjust_player_selection(current_player.pick_square)
      piece = piece_on_square(start)

      return start if start == 'save' || start == 'draw'
      return start if not_your_piece(start) == false
      puts "You can't move that piece. Please try again."
    end  
  end

  def move_to(selected_piece)
    puts "Where would you like to move your #{selected_piece}?"
    loop do
      finish = adjust_player_selection(current_player.pick_square)

      return finish 
    end  
  end

  def piece_on_square(coordinates)
    @pieces.select { |piece| piece.current == coordinates }.pop
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

