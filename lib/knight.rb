class Knight 
  attr_accessor :current, :symbol
  attr_reader :starting, :team

  def initialize(team, num)
    @starting = get_start(team, num)
    @current = @starting
    @symbol = team == 'white' ? "\u{2658}" : "\u{265E}"
    @team = team
  end  
  
  def get_start(team, num)
    if num == 0 
      team == 'white' ? [7, 1] : [0, 1]
    else 
      team == 'white' ? [7, 6] : [0, 6]  
    end
  end

  def to_s
    "Knight"
  end
end