class Bishop
  include Move 

  attr_accessor :current
  attr_reader :starting, :team, :symbol

  def initialize(team, num)
    @starting = get_start(team, num)
    @current = @starting
    @symbol = team == 'white' ? "\u{2657}" : "\u{265D}"
    @team = team
  end  

  def get_start(team, num)
    if num == 0 
      team == 'white' ? [7, 2] : [0, 2]
    else 
      team == 'white' ? [7, 5] : [0, 5]  
    end
  end

  def possible_moves()
    moves = diagonal_down_moves(), diagonal_down_moves2(), 
            diagonal_up_moves(), diagonal_up_moves2()
  end

  def diagonal_down_move_options
    [[-1,-1], [-2,-2], [-3,-3], [-4,-4], [-5,-5], [-6,-6], [-7,-7]]
  end

  def diagonal_down_move_options2
    [[-1,1], [-2,2], [-3,3], [-4,4], [-5,5], [-6,6], [-7,7]]
  end

  def diagonal_up_move_options
    [[1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7]]
  end

  def diagonal_up_move_options2
    [[1,-1], [2,-2],  [3,-3], [4,-4], [5,-5], [6,-6], [7,-7]]
  end
  
  def to_s
    "Bishop"
  end
end