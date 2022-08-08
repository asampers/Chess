class King
  include Move

  attr_accessor :current
  attr_reader :starting, :team, :symbol

  def initialize(team)
    @starting = team == 'white' ? [7, 4] : [0, 4]
    @current = @starting
    @symbol = team == 'white' ? "\u{2654}" : "\u{265A}"
    @team = team
  end  
  
  def move_options
    [[-1,0], [1,0], [0,-1], [0, 1], 
    [-1,-1],[-1,1], [1,-1], [1, 1]]
  end

  def to_s
    "King"
  end
end