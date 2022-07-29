class Bishop
  attr_accessor :current
  attr_reader :symbol

  def initialize(starting_location, num)
    @current = get_start(starting_location, num)
    @symbol = starting_location.odd? ? "\u{2657}" : "\u{265D}"
  end  

  def get_start(starting_location, num)
    if num == 0 
      starting_location.odd? ? [7, 2] : [0, 2]
    else 
      starting_location.odd? ? [7, 5] : [0, 5]  
    end
  end
end