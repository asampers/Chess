require 'yaml'

class Player

  attr_reader :name, :team

  def initialize(team, name=get_name())
    @name = name
    @team = team
  end

  def get_name
    print "Please enter the name for this player: "
    name = gets.chomp
    puts "Thank you, #{name}."
    return name 
  end

  def to_s
    "#{@name}"
  end 


  def pick_square
    loop do
      print "Enter letter and number of square: "
      selection = gets.chomp.downcase
      return selection if selection == 'save' || selection == 'draw'
      return selection.split('').reverse if selection.match(/[a-h][1-8]/)

      puts "Please enter letters 'a-h' and numbers '1-8' without space inbetween."
      puts "You may also enter 'save' or 'draw' to end the game."  
    end  
  end

  def pick_piece
    puts "What piece would you like your pawn to become?"
      loop do 
        answer = gets.chomp.capitalize
        return answer if ['Rook', 'Bishop', 'Knight', 'Queen'].include?(answer)
        print "Please type one of the following: "
        puts "Rook, Bishop, Knight, Queen"
      end  
  end
end