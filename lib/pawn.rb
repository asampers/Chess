class Pawn
  include Move 
  
  attr_accessor :current
  attr_reader :starting, :team, :symbol

  def initialize(team, num)
    @starting = team == 'white' ? [6, num] : [1, num]  
    @current = @starting
    @symbol = team == 'white' ? "\u{2659}" : "\u{265F}"
    @team = team
  end  

  def move_options
    return get_move_options()
  end
  
  def get_move_options
    if @team == 'white' && @starting == @current
      [[-1,0], [-2,0]]
    elsif @team == 'white'
      [-1,0]
    elsif @team == 'black' && @starting == @current
      [[2,0], [1,0]]
    else
      [[1,0]] 
    end     
  end
 

  def to_s
    "Pawn"
  end
end