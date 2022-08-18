class King
  include Move
  include Check

  attr_accessor :current
  attr_reader :starting, :team, :symbol

  def initialize(team)
    @starting = get_start()
    @current = @starting
    @symbol = get_symbol()
    @team = team
  end  
  
  def get_start(team)
    team == 'white' ? [7, 4] : [0, 4]
  end

  def get_symbol(team)
    team == 'white' ? "\u{2654}" : "\u{265A}"
  end

  def move_options
    [[-1,0], [1,0], [0,-1], [0, 1], 
    [-1,-1],[-1,1], [1,-1], [1, 1]]
  end

  

  def to_s
    "King"
  end
end