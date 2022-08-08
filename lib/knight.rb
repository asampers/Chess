class Knight 
  include Move

  attr_accessor :current 
  attr_reader :starting, :team, :symbol

  def initialize(team, num)
    @starting = get_start(team, num)
    @current = @starting
    @symbol = get_symbol(team)
    @team = team
  end  
  
  def get_start(team, num)
    if num == 0 
      team == 'white' ? [7, 1] : [0, 1]
    else 
      team == 'white' ? [7, 6] : [0, 6]  
    end
  end

  def get_symbol(team)
    team == 'white' ? "\u{2658}" : "\u{265E}"
  end

  def move_options
    [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [2, -1], [-1, 2], [-2, 1]]
  end

  def to_s
    "Knight"
  end
end