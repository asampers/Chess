require 'yaml'

class Queen
  include Move
  include Check

  attr_accessor :current
  attr_reader :starting, :team, :symbol

  def initialize(team, num=0)
    @current = get_start(team)
    @symbol =  get_symbol(team)
    @team = team
  end  

  def get_start(team)
    team == 'white' ? [7, 3] : [0, 3]
  end 

  def get_symbol(team)
    team == 'white' ? "\u{2655}" : "\u{265B}"
  end

  def can_move?(path, moves, finish, board)
    return true if path.all? {|space| board.square_free?(space)}

    false
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
    [[1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0]],
    [[-1,-1], [-2,-2], [-3,-3], [-4,-4], [-5,-5], [-6,-6], [-7,-7]],
    [[-1,1], [-2,2], [-3,3], [-4,4], [-5,5], [-6,6], [-7,7]],
    [[1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7]],
    [[1,-1], [2,-2], [3,-3], [4,-4], [5,-5], [6,-6], [7,-7]]]
  end
 
  def to_s
    "Queen"
  end
end