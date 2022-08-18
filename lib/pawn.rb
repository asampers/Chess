class Pawn
  include Move 
  include Check

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

  def possible_moves(start=@current)
    moves = get_move_options.map do |option| 
              option.map do |move|
                [start[0] + move[0], start[1] + move[1]]
              end 
            end
    moves.map {|move| keep_legal_moves(move)} 
  end

  def get_move_options
    if @team == 'white' && @starting == @current
      [[[-1,0], [-2,0]], [[-1,-1], [-1, 1], [-2,-1], [-2,1]]]
    elsif @team == 'white'
      [[[-1,0]], [[-1,-1], [-1,1]]]
    elsif @team == 'black' && @starting == @current
      [[[1,0], [2,0]], [[1,-1], [1,1], [2,-1], [2,1]]]
    else
      [[[1,0]], [[1,-1], [1,1]]] 
    end     
  end

  def can_move?(path, moves, finish, board)
    if board.square_free?(finish)
      moves.delete_at(1)
      return moves.flatten!(1).include?(finish) && moves.all? {|space| board.square_free?(space)}
    elsif board.square_free?(finish) == false
      return moves.flatten(1).include?(finish)
    end
    
  end 

  

  def to_s
    "Pawn"
  end
end