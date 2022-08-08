module Move

  def move(destination)
    @current = destination
  end

  def keep_legal_first_visit(board, moves, turns)
    moves.keep_if {|move| board.legal_move?(move)}
    moves
    moves.keep_if {|move| first_visit?(move, turns)}
    return moves
  end

  def first_visit?(move, turns)
    turns.each do |turn| 
      if turn.include?(move)
        return false
      end 
    end 
    true  
  end

  def possible_moves(start, finish, turns, visited)
    return if turns.include?(finish)
    moves = move_options.map do |move|
     [start[0] + move[0], start[1] + move[1]]
    end 
    keep_legal_first_visit(board=Board.new, moves, turns) 
    visited[start] = moves unless moves.empty?
    turns << moves unless moves.empty?
  end

  def make_all_possible_moves(start, finish, selected_piece, turns, visited=Hash.new)
    turns.each_with_index do |turn, index|
      if turn.include?(finish)
        return visited
      end 
      turn.each do |move|
        selected_piece.possible_moves(move, finish, turns, visited) 
      end 
    end    
  end

  def find_path(visited, moves, current, start)
    until moves.include?(start)
      visited.each_pair do |key, value|
        if value.include?(current)
          current = key
          moves.unshift(key)
          return moves if current == start
        end 
      end 
    end      
  end

end