module MoveLong

  def vertical_moves(start=@current)
    moves = vertical_move_options.map do |move|
      [start[0] + move[0], start[1] + move[1]]
    end 
    keep_legal_first_visit(board=Board.new, moves)
  end

  def horizontal_moves(start=@current)
    moves = horizontal_move_options.map do |move|
      [start[0] + move[0], start[1] + move[1]]
    end 
    keep_legal_first_visit(board=Board.new, moves)
  end

  def make_all_possible_moves(start, finish, selected_piece, turns, visited=Hash.new)
    turns.each_with_index do |turn, index|
      turn.each do |move|
        selected_piece.possible_moves(move, finish, turns, visited) 
      end 
     
    end 
    visited    
  end


end