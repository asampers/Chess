class Pawn

  attr_accessor :current
  attr_reader :symbol

  def initialize(starting_location, num)
    @current = get_start(starting_location, num)
    @symbol = starting_location.odd? ? "\u{2659}" : "\u{265F}"
  end  

  def get_start(starting_location, num)
    if num == 0 
      starting_location.odd? ? [6, 0] : [1, 0]
    else 
      starting_location.odd? ? [6, num] : [1, num]  
    end
  end
  
end