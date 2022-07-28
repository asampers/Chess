@board = Array.new(8) { Array.new(8)}

def print_board
    print "\e[32m  a b c d e f g h\n\e[0m"
    @board.each_with_index do |line, index|
      changed = line.map.each_with_index {|spot, ind| select_background(index, ind) }.join
      puts "\e[34m#{(@board.size) - index}\e[0m #{changed} \e[34m#{(@board.size) - index}\e[0m"
    end
    puts "\e[32m  a b c d e f g h\n\e[0m"
  end

def select_background(row_index, column_index)
  (row_index + column_index).even? ? "\e[46m  \e[0m" : "\e[44m  \e[0m" 
end

print_board()