class Queen
  attr_accessor :current
  attr_reader :symbol

  def initialize(starting_location)
    @current = starting_location.odd? ? [7, 3] : [0, 3]
    @symbol = starting_location.odd? ? "\u{2655}" : "\u{265B}"
  end  

 
end