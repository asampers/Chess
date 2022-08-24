require 'yaml'

class King
  include Move
  include Check

  attr_accessor :current
  attr_reader :starting, :team, :symbol

  def initialize(team)
    @starting = get_start(team)
    @current = @starting
    @symbol = get_symbol(team)
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

  def castling_move_options
    [[[0,1], [0,2]],[[0,-1],[0,-2]]]
  end
  

  def to_s
    "King"
  end
end