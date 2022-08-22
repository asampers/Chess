module Check
  
  def out_of_check(finish)
    if king_in_check?()
      return test_all_possible_moves().include?(finish)
    end  
    true
  end
  
  def king_in_check?
    can_reach_king?().any?
  end

  def checkmate_stalemate(opponent)
    return if test_all_possible_moves().any?

    if king_in_check?()
      puts "Game Over: Checkmate"
      puts "#{opponent} wins!"
      return 'stop'
    elsif king_in_check?() == false
      puts "Game Over: It's a stalemate."
      return 'stop'
    end  
  end


  def drawn_game()
    puts "-- Players have agreed to a draw. Game over. --"
    return 'stop'
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

  def attempt_movement(piece, finish, board=@board)
    moves = piece.possible_moves()
    path = find_path(moves, finish)
    piece.can_move?(path, moves, finish, board)
  end

  def can_reach_king?
    opponent_pieces.map do |piece|
      attempt_movement(piece, king_position()) 
    end 
  end

  def not_your_piece(destination)
    yours = your_pieces.select { |piece| piece.current == destination }
    yours.none?
  end
  
  def test_all_possible_moves
    options = your_pieces.map do |fake|
      possible_moves_out_of_check(fake)
    end 
    options.keep_if {|one| one.any?}
    options.flatten(1)
  end

  def possible_moves_out_of_check(fake) 
    moves = fake.possible_moves
    options = []
    if fake.class == King || fake.class == Knight
      moves = Array[moves]
    end
      moves.map do |turn|
        turn.keep_if do |destination|
         next if attempt_movement(fake, destination, board=@board) == false || not_your_piece(destination) == false
         stored = fake.current
         stored_opponent = piece_on_square(destination)
         fake.move(destination) if attempt_movement(fake, destination, board=@board) && not_your_piece(destination)
         pieces.delete(stored_opponent) unless stored_opponent.nil? || stored_opponent.team == fake.team
         
         board.recognize_move(stored, destination, pieces)

         options << destination if king_in_check?() == false 
         
         fake.move(stored)
         board.clear_space(destination)
         pieces << stored_opponent unless stored_opponent.nil?
         board.place_pieces(pieces)
        end 
      end     
    options
  end 

end