class Rook
  include Move
  include Check

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
      team == 'white' ? [7, 0] : [0, 0]
    else 
      team == 'white' ? [7, 7] : [0, 7]  
    end
  end

  def get_symbol(team)
    team == 'white' ? "\u{2656}" : "\u{265C}"
  end

  def can_move?(path, moves, finish, board)
    return true if path.all? {|space| board.square_free?(space)}

    false
  end 

  def castle_move
    if @team == 'white' && @current == [7,0]
      @current = [7,3]
    elsif @team == 'white' && @current == [7,7]
      @current = [7,5]
    elsif @team == 'black' && @current == [0,0]
      @current = [0,3]
    elsif @team == 'black' && @current == [0,7]    
      @current = [0,5]
    end    
  end

  def possible_moves(start=@current)
    moves = get_move_options.map do |option| 
              option.map do |move|
                [start[0] + move[0], start[1] + move[1]]
              end 
            end
    moves.map {|move| keep_legal_moves(move)}            
  end

  def get_move_options
    [[[0,-1], [0,-2], [0,-3], [0,-4], [0,-5], [0,-6], [0,-7]],
    [[0, 1], [0, 2], [0,3], [0,4], [0,5], [0,6], [0,7]],
    [[-1,0], [-2, 0], [-3,0], [-4,0], [-5,0], [-6,0], [-7,0]],
    [[1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0]]]
  end 

  def to_s
    "Rook"
  end
end