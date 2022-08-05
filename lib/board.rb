class Board 
  attr_accessor :spaces

  def initialize
    @spaces = board()
  end

  def board()
    [0,1,2,3,4,5,6,7].repeated_permutation(2).to_a
  end

  def place_pieces(pieces)
    @spaces.map! do |space|
      pieces.each do |piece|
        if piece.current == space
         space.push(piece.symbol)
        end 
      end
      space
    end  
  end

  def clear_space(start)
    @spaces.each do |space|
      if space.include?(start[0] && start[1])
        space.delete_at(2)
      end 
    end    
  end

  def display
    print "\e[32m   a  b  c  d  e  f  g  h\n\e[0m"
    rows = create_rows()
    rows.each_with_index do |line, index|
      changed = line.map.each_with_index {|spot, ind| select_background(index, ind, spot) }.join
      puts "\e[34m#{8 - index}\e[0m #{changed} \e[34m#{8 - index}\e[0m"
    end
    puts "\e[32m   a  b  c  d  e  f  g  h\n\e[0m"
  end

  def create_rows
    rows = []
    i = 0
    while i < @spaces.length 
      rows << @spaces[i..i+7]
      i += 8
    end
    rows 
  end

  def select_background(row_index, column_index, spot)
    if spot.length == 2
      (row_index + column_index).even? ? "\e[46m   \e[0m" : "\e[44m   \e[0m" 
    else
      (row_index + column_index).even? ? "\e[46m #{spot[2]} \e[0m" : "\e[44m #{spot[2]} \e[0m"  
    end  
  end
end