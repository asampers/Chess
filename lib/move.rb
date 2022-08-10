module Move

  def move(destination)
    @current = destination
  end

  def keep_legal_first_visit(board, moves)
    moves.keep_if {|move| board.legal_move?(move)}
    moves
  end

  def first_visit?(move, turns)
    turns.each do |turn| 
      if turn.include?(move)
        return false
      end 
    end 
    true  
  end

  def possible_moves(start=@current)
    moves = move_options.map do |move|
     [start[0] + move[0], start[1] + move[1]]
    end 
    keep_legal_first_visit(board=Board.new, moves) 
  end

  def clear_path?(path, board=@board)
    return true if path.length == 1
    return true if path.all? {|space| board.square_free?(space)}
    
    false
  end

  def find_path(moves, finish)
    path = []
    moves.each do |move| 
      path << move
      return path if move == finish    
    end
  end

end