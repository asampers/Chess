class King
  attr_accessor :current, :symbol
  attr_reader :starting, :team

  def initialize(team)
    @starting = team == 'white' ? [7, 4] : [0, 4]
    @current = @starting
    @symbol = team == 'white' ? "\u{2654}" : "\u{265A}"
    @team = team
  end  
  
  

  def to_s
    "King"
  end
end