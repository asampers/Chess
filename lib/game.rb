
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
      pawn_promotion()

      switch_players!()
    end
  end


  def player_turn
    options = test_all_possible_moves()
    return 'stop' if checkmate_stalemate(opponent, options) == 'stop'
    p "Your king is in check!" if king_in_check?() 
    loop do
      start = move_from() 
      
      return save_game(self) if start == 'save'
      return drawn_game() if start == 'draw'

      selected_piece = piece_on_square(start)

      finish = move_to(selected_piece)
      final_square = piece_on_square(finish)
      
      break if castling(selected_piece, finish)

      moves = selected_piece.possible_moves
      path = find_path(moves, finish)

      if selected_piece.can_move?(path, moves, finish, @board) && out_of_check(selected_piece, finish) && not_your_piece(finish)
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

  def pawn_promotion()
    pawns = @pieces.select {|pawn| pawn.class == Pawn}
    piece_to_promote = pawns.select {|pawn| [0,7].include?(pawn.current[0])}.pop
    if piece_to_promote
      selection = current_player.pick_piece
      new_piece = make_new_piece(current_player, selection)
      new_piece.current = piece_to_promote.current
      @pieces.delete(piece_to_promote)
      @pieces << new_piece
      @board.place_pieces(@pieces)
      puts "#{current_player} got a new #{selection}." 
    end  
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

