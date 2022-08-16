module Check
  
  def king_in_check?
    can_reach_king?()
  end

  def opponent_pieces
    pieces.select {|piece| piece.team == opponent.team}
  end

  def your_pieces
    pieces.select {|piece| piece.team == current_player.team}
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
      attempt_movement(piece)
    end 
    attempts.any?
  end

  def not_your_piece(destination)
    yours = your_pieces.select { |piece| piece.current == destination }
    yours.none?
  end

  def create_fake_board(fake_pieces)
    fake = Board.new
    fake.place_pieces(fake_pieces)
  end
  
  def test_all_possible_moves
    your_pieces.map do |fake|
      all_possible_destinations(fake)
    end 
    
  end

  def all_possible_destinations(fake)
    #fake_board = Board.new
    moves = fake.possible_moves
    if fake.class == Pawn || fake.class == King || fake.class == Knight
      moves.map do |move|
         next if attempt_movement(fake, board=@board, finish=move) == false || not_your_piece(move) == false
         stored = fake.current
         stored_opponent = piece_on_square(move).pop
        
         fake.move(move) if attempt_movement(fake, board=@board, finish=move) && not_your_piece(move)
         pieces.delete(stored_opponent) unless stored_opponent.nil? || stored_opponent.team == fake.team
         board.clear_space(stored)
         board.clear_space(move)
         board.place_pieces(pieces)
         
         p "If #{fake} moves to #{fake.current}: #{king_in_check?()}" if king_in_check?() == false
         fake.current = stored
         board.clear_space(move)
         pieces << stored_opponent unless stored_opponent.nil?
         board.place_pieces(pieces)
      end  
    else 
      moves.map do |turn|
        turn.map do |destination|
         next if attempt_movement(fake, board=@board, finish=destination) == false || not_your_piece(destination) == false
         stored = fake.current
         stored_opponent = piece_on_square(destination).pop
         fake.move(destination) if attempt_movement(fake, board=@board, finish=destination) && not_your_piece(destination)
         pieces.delete(stored_opponent) unless stored_opponent.nil? || stored_opponent.team == fake.team
         board.clear_space(stored)
         board.clear_space(destination)
         board.place_pieces(pieces)

         p "If #{fake} moves to #{destination}: #{king_in_check?()}" if king_in_check?() == false
         fake.current = stored
         board.clear_space(destination)
         pieces << stored_opponent unless stored_opponent.nil?
         board.place_pieces(pieces)
        end 
      end   
    end 
      
  end 

end