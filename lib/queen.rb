class Queen
  include Move

  attr_accessor :current
  attr_reader :starting, :team, :symbol

  def initialize(team)
    @current = team == 'white' ? [7, 3] : [0, 3]
    @symbol = team == 'white' ? "\u{2655}" : "\u{265B}" 
    @team = team
  end  

  def move_options
    [[-1,-1], [-1,1], [1,-1], [1, 1], 
    [-1,0], [1,0], [0,-1], [0, 1]]
  end
 
  def to_s
    "Queen"
  end
end