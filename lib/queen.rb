class Queen
  attr_accessor :current, :symbol
  attr_reader :starting, :team

  def initialize(team)
    @starting = team == 'white' ? [7, 3] : [0, 3]
    @current = @starting
    @symbol = team == 'white' ? "\u{2655}" : "\u{265B}" 
    @team = team
  end  


 
  def to_s
    "Queen"
  end
end