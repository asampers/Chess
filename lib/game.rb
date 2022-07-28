
require_relative '../lib/player.rb'

module Display

  def print_board
    print "\e[32m   a  b  c  d  e  f  g  h\n\e[0m"
    @board.each_with_index do |line, index|
      changed = line.map.each_with_index {|spot, ind| select_background(index, ind, spot) }.join
      puts "\e[34m#{(@board.size) - index}\e[0m #{changed} \e[34m#{(@board.size) - index}\e[0m"
    end
    puts "\e[32m   a  b  c  d  e  f  g  h\n\e[0m"
  end

  def select_background(row_index, column_index, spot)
    if spot.nil?
      (row_index + column_index).even? ? "\e[46m   \e[0m" : "\e[44m   \e[0m" 
    else
      (row_index + column_index).even? ? "\e[46m #{spot} \e[0m" : "\e[44m #{spot} \e[0m"  
    end   
  end
end

class Game
  include Display

  attr_accessor :board, :players

  def initialize
    @board = Array.new(8) { Array.new(8) }
    @players = [Player.new(self, 1), Player.new(self, 8)]
  end

end