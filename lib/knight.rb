class Knight 
  attr_accessor :current
  attr_reader :symbol

  def initialize(starting_location, num)
    @current = get_start(starting_location, num)
    @symbol = starting_location.odd? ? "\u{2658}" : "\u{265E}"
  end  

  def get_start(starting_location, num)
    if num == 0 
      starting_location.odd? ? [7, 1] : [0, 1]
    else 
      starting_location.odd? ? [7, 6] : [0, 6]  
    end
  end

end