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

  def move_options
    [[-1,-1], [-1,1], [1,-1], [1, 1]]
  end

  def to_s
    "Bishop"
  end
end