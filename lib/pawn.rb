class Pawn
  include Move 

  attr_accessor :current
  attr_reader :starting, :team, :symbol

  def initialize(team, num)
    @starting = get_start(team, num)
    @current = @starting
    @symbol = team == 'white' ? "\u{2659}" : "\u{265F}"
    @team = team
  end  

  def get_start(team, num)
    team == 'white' ? [6, num] : [1, num]  
  end 

  def move_options
    get_move_options()
  end
  
  def get_move_options
    if @team == 'white' && @starting == @current
      [[-1,0], [-2,0]]
    elsif @team == 'white'
      [[-1,0]]
    elsif @team == 'black' && @starting == @current
      [[2,0], [1,0]]
    else
      [[1,0]] 
    end     
  end

  def move_diagonally(moves)
    diagonal = moves.map do |move|
      [move[0] + 0, move[1] - 1]  
    end  
    diagonal2 = moves.map do |move|
      [move[0] + 0, move[1] + 1]
    end  
    moves = moves + diagonal + diagonal2
    keep_legal_moves(moves)
  end 

  def can_move?(path, moves, finish, board)
    return true if pawn_capturing?(moves, finish, board)
    return moves.include?(finish) && path.all? {|space| board.square_free?(space)}
  end 

  def to_s
    "Pawn"
  end
end