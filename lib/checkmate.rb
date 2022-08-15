module Checkmate

  def king_in_check?
    can_reach_king?()
  end

  def opponent_pieces
    pieces.select {|piece| piece.team == opponent.team}
  end

  def your_king
    king = pieces.select {|piece| piece.team == current_player.team && piece.class == King}.pop
  end

  def king_position
    your_king.current
  end

  def attempt_movement(piece, board=@board, finish=king_position())
    moves = piece.possible_moves()
    path = find_path(moves, finish)
    piece.can_move?(path, moves, finish, board)
  end

  def can_reach_king?
    attempts = opponent_pieces.map do |piece|
      ["#{piece}", "#{piece.team}", attempt_movement(piece)]
    end  
  end

  
end