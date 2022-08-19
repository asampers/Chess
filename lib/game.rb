
require_relative '../lib/player.rb'
require_relative '../lib/pieces.rb'
require_relative '../lib/move.rb'
require_relative '../lib/check.rb'
require_relative '../lib/board.rb'
require_relative '../lib/save_game.rb'

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
    #loop do 
    #  @board.display
    player_turn()
    switch_players!()
    player_turn()
    switch_players!()
    player_turn()
    switch_players!()
    player_turn()
    switch_players!()
    player_turn()
    switch_players!()
    player_turn()
    switch_players!()
    player_turn()
    switch_players!()
    player_turn()
    switch_players!()
    player_turn()
    switch_players!()
    player_turn()
    switch_players!()
    player_turn()
    switch_players!()
    player_turn()
  end


  def player_turn
    @board.display
    p "Your king is in check!" if king_in_check?()

    p test_all_possible_moves() if king_in_check?() 
    puts "Which piece would you like to move, #{current_player}?"
    start = adjust_player_selection(current_player.pick_square)
      
    return save_game(self) if start == 'save'

    selected_piece = piece_on_square(start)
    puts "Where would you like to move your #{selected_piece}?"
    finish = adjust_player_selection(current_player.pick_square)

    final_square = piece_on_square(finish)
    
    castling(selected_piece, finish)

    moves = selected_piece.possible_moves
    path = find_path(moves, finish)

    selected_piece.move(finish) if selected_piece.can_move?(path, moves, finish, @board)
    
    @pieces.delete(final_square) 

    @board.recognize_move(start, finish, @pieces)
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

