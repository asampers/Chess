module Move

  def move(destination)
    @current = destination
  end

  def your_rooks
    rooks = pieces.select {|piece| piece.team == current_player.team && piece.class == Rook}
  end

  def closest_rook(finish)
    routes = your_rooks.map do |rook|
      moves = rook.possible_moves
      path = find_path(moves, finish)
    end  
    
    if routes[0].length < routes[1].length
      return your_rooks.first
    else
      return your_rooks.pop
    end    

  end

  def castling(selected_piece, finish, board=@board, pieces=@pieces)
    
    if castling_requirements_met(selected_piece, finish) && castling_path_clear?(selected_piece, finish)
      king_start = selected_piece.current
      rook_start = closest_rook(finish).current
      
      selected_piece.move(finish)
      closest_rook(finish).castle_move
      
      board.clear_space(king_start)
      board.clear_space(rook_start)
      board.place_pieces(pieces)
      board.display
    end
  end

  def castling_requirements_met(selected_piece, finish)
    return selected_piece.class == King && 
      selected_piece.current == selected_piece.starting &&
      closest_rook(finish).current == closest_rook(finish).starting
  end 

  def castling_path_clear?(selected_piece, finish, board=@board)
    path = selected_piece.find_castling_path()
    p path
    path.keep_if {|direction| direction.include?(finish)}
    p path.flatten!(1) 
    p path.all? {|space| board.square_free?(space)}
    return path.all? {|space| board.square_free?(space)}
  end 

  def find_castling_path(start=@current)
    castling_move_options.map do |option|
      option.map do |move|
        [start[0] + move[0], start[1] + move[1]]
      end  
    end
  end

  def keep_legal_moves(board=Board.new, moves)
    moves.keep_if {|move| board.legal_move?(move)}
    moves
  end

  def possible_moves(start=@current)
    moves = move_options.map do |move|
      [start[0] + move[0], start[1] + move[1]]
    end
    keep_legal_moves(moves) 
  end

  def can_move?(path, moves, finish, board)
    return true if moves.include?(finish)  
    
    false
  end

  def find_path(moves, finish)
    option = moves.select {|turn| turn.include?(finish)}.pop
    path = []
    return moves if option.nil?
    option.each do |move|
      return path if move == finish
      path << move
    end 
  end
end