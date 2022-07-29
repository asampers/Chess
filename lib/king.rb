class King
  attr_accessor :current
  attr_reader :symbol

  def initialize(starting_location)
    @current = starting_location.odd? ? [7, 4] : [0, 4]
    @symbol = starting_location.odd? ? "\u{2654}" : "\u{265A}"
  end  

 
end