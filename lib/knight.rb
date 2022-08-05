class Knight 
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

  def move(destination)
    @current = destination
  end

  def possible_moves
    [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [2, -1], [-1, 2], [-2, 1]]
  end

  def possible_coordinates(current=@current)
    possible_coordinates = possible_moves.map do |move|
      [current[0] + move[0], current[1] + move[1]]
    end  
  end

  def to_s
    "Knight"
  end
end