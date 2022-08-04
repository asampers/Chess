class Pawn

  attr_accessor :current, :symbol
  attr_reader :starting, :going, :team

  def initialize(team, num)
    @starting = get_start(team, num)
    @current = @starting
    @symbol = team == 'white' ? "\u{2659}" : "\u{265F}"
    @team = team
    #@going = player.odd? ? '-' : '+'
  end  

  def get_start(team, num)
    if num == 0 
      team =='white' ? [6, 0] : [1, 0]
    else 
      team == 'white' ? [6, num] : [1, num]  
    end
  end
  
  def to_s
    "Pawn"
  end
end