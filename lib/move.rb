module Move

  def move(destination)
    @current = destination
  end

  def your_rooks
    rooks = pieces.select {|piece| piece.team == current_player.team && piece.class == Rook}
  end

  def find_rook_path(finish)
    your_rooks.map do |rook|
              moves = rook.possible_moves
              path = find_path(moves, finish)
    end  
  end 

  def closest_rook(finish)
    routes = find_rook_path(finish)
    
    if routes[0].length < routes[1].length
      return your_rooks.first
    else
      return your_rooks.pop
    end    
  end

  def castling(king, finish, board=@board, pieces=@pieces)
    if castling_requirements_met?(king, finish) && castling_path_clear?(king, finish)
      king_start = king.current
      rook_start = closest_rook(finish).current
      
      king.move(finish)
      closest_rook(finish).castle_move

      board.recognize_move(king_start, rook_start, pieces)
    end
  end

  def castling_requirements_met?(king, finish)
    return king.class == King && 
      king.current == king.starting &&
      closest_rook(finish).current == closest_rook(finish).starting &&
      [[0,2], [0,6], [7,2], [7,6]].include?(finish)
  end 

  def castling_path_clear?(king, finish, board=@board)
    p path = king.find_castling_path(finish)
    return path.all? {|space| board.square_free?(space)}
  end 

  def find_castling_path(finish, start=@current)
    path = castling_move_options.map do |option|
            option.map do |move|
              [start[0] + move[0], start[1] + move[1]]
            end  
    end
    path.keep_if {|move| move.include?(finish)}
    path.flatten!(1) 
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