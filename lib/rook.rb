class Rook
  include Move

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

  def move_options
    [[-1,0], [1,0], [0,-1], [0, 1]]
  end

  def to_s
    "Rook"
  end
end