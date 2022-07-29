module Pieces

  def create_pieces(num)
    pieces = make_rooks(num) +
            make_pawns(num) +
            make_knights(num) +
            make_bishops(num)
    pieces << Queen.new(num)
    pieces << King.new(num)

  end 

  def make_rooks(num)
    return Rook.new(num, 0), Rook.new(num, 1)
  end

  def make_knights(num)
    return Knight.new(num, 0), Knight.new(num, 1)
  end

  def make_bishops(num)
    return Bishop.new(num, 0), Bishop.new(num, 1)
  end

  def make_pawns(num)
    i = 0
    eight_pawns = []
    until i == 8
      eight_pawns << Pawn.new(num, i)
      i += 1
    end 
    eight_pawns  
  end

end