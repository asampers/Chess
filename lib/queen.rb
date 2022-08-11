class Queen
  include Move

  attr_accessor :current
  attr_reader :starting, :team, :symbol

  def initialize(team)
    @current = team == 'white' ? [7, 3] : [0, 3]
    @symbol = team == 'white' ? "\u{2655}" : "\u{265B}" 
    @team = team
  end  

  def possible_moves()
    moves = vertical_moves(), horizontal_moves(), 
            vertical_moves2(), horizontal_moves2(),
            diagonal_down_moves(), diagonal_down_moves2(), 
            diagonal_up_moves(), diagonal_up_moves2()
  end

  def horizontal_move_options
    [[0,-1], [0, 1], [0,-2], [0, 2], [0,-3], [0,3], 
      [0,-4], [0,4], [0,-5], [0,5], [0,-6], [0,6], [0,-7], [0,7]]
  end

  def vertical_move_options
    [[-1,0], [1,0], [-2, 0], [2,0], [-3,0], [3,0], 
     [-4,0], [4,0], [-5,0], [5,0],[-6,0], [6,0], [-7,0], [7,0]]
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
    "Queen"
  end
end