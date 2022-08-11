class Rook
  include Move
  include MoveLong

  attr_accessor :current
  attr_reader :starting, :team, :symbol

  def initialize(team, num)
    @starting = get_start(team, num)
    @current = @starting
    @symbol = team == 'white' ? "\u{2656}" : "\u{265C}"
    @team = team
  end  

  def get_start(team, num)
    if num == 0 
      team == 'white' ? [7, 0] : [0, 0]
    else 
      team == 'white' ? [7, 7] : [0, 7]  
    end
  end

  def possible_moves()
    moves = vertical_moves(), vertical_moves2(),
            horizontal_moves(), horizontal_moves2()
  end


  def horizontal_move_options
    [[0,-1], [0,-2], [0,-3], [0,-4], [0,-5], [0,-6], [0,-7]]
  end

  def horizontal_move_options2
    [[0, 1], [0, 2], [0,3], [0,4], [0,5], [0,6], [0,7]]
  end

  def vertical_move_options
    [[-1,0], [-2, 0], [-3,0], [-4,0], [-5,0], [-6,0], [-7,0]]
  end

  def vertical_move_options2
    [[1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0]]
  end

  def to_s
    "Rook"
  end
end