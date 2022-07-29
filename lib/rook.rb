class Rook
  attr_accessor :current, :symbol

  def initialize(starting_location, num)
    @current = get_start(starting_location, num)
    @symbol = starting_location.odd? ? "\u{2656}" : "\u{265C}"
  end  

  def get_start(starting_location, num)
    if num == 0 
      starting_location.odd? ? [7, 0] : [0, 0]
    else 
      starting_location.odd? ? [7, 7] : [0, 7]  
    end
  end

end