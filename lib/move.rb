module Move

  def move(destination)
    @current = destination
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

  def pawn_capturing?(moves, finish, board)
    if board.square_free?(finish) == false 
      move_diagonally(moves).include?(finish)
    end  
     
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