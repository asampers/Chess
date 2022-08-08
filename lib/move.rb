module Move

  def move(destination)
    @current = destination
  end

  def possible_coordinates(current=@current)
    possible_coordinates = possible_moves.map do |move|
      [current[0] + move[0], current[1] + move[1]]
    end  
  end
  


end