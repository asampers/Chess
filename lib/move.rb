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

  def vertical_moves(start=@current)
    moves = vertical_move_options.map do |move|
      [start[0] + move[0], start[1] + move[1]]
    end 
    keep_legal_moves(moves)
  end

  def vertical_moves2(start=@current)
    moves = vertical_move_options2.map do |move|
      [start[0] + move[0], start[1] + move[1]]
    end 
    keep_legal_moves(moves)
  end

  def horizontal_moves(start=@current)
    moves = horizontal_move_options.map do |move|
      [start[0] + move[0], start[1] + move[1]]
    end 
    keep_legal_moves(moves)
  end

  def horizontal_moves2(start=@current)
    moves = horizontal_move_options2.map do |move|
      [start[0] + move[0], start[1] + move[1]]
    end 
    keep_legal_moves(moves)
  end

  def diagonal_down_moves(start=@current)
    moves = diagonal_down_move_options.map do |move|
      [start[0] + move[0], start[1] + move[1]]
    end 
    keep_legal_moves(moves)
  end

  def diagonal_down_moves2(start=@current)
    moves = diagonal_down_move_options2.map do |move|
      [start[0] + move[0], start[1] + move[1]]
    end 
    keep_legal_moves(moves)
  end  

  def diagonal_up_moves(start=@current)
    moves = diagonal_up_move_options.map do |move|
      [start[0] + move[0], start[1] + move[1]]
    end 
    keep_legal_moves(moves)
  end

  def diagonal_up_moves2(start=@current)
    moves = diagonal_up_move_options2.map do |move|
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
    return true if path.all? {|space| board.square_free?(space)}
    
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