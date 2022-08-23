module Pieces

  def create_pieces(team)
    pieces = make_rooks(team) +
            make_knights(team) +
            make_bishops(team)
    pieces << Queen.new(team)
    pieces << King.new(team)
    pieces + make_pawns(team) 
  end 

  def make_rooks(team)
    return Rook.new(team, 0), Rook.new(team, 1)
  end

  def make_knights(team)
    return Knight.new(team, 0), Knight.new(team, 1)
  end

  def make_bishops(team)
    return Bishop.new(team, 0), Bishop.new(team, 1)
  end

  def make_pawns(team)
    i = 0
    eight_pawns = []
    until i == 8
      eight_pawns << Pawn.new(team, i)
      i += 1
    end 
    eight_pawns  
  end

  def make_new_piece(current_player, selection)
    klass = Object.const_get selection
    klass.new(current_player.team, num=0)
   end 

end