module SaveGame

  def play_from_saved_game
    if Dir.glob('saved_games/*').length > 0
      puts "Would you like to play from a saved game? Y or N"
      answer = gets.chomp.upcase
      if answer == "Y"
        choose_saved_game()
      end
    end
  end  

  def save_game(game)
    puts "...saving game..."
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    puts "What would you like to name your saved game?"
    answer = gets.chomp 
    filename = "saved_games/#{answer}.yml"

    File.open(filename, 'w') {|file| file.puts YAML.dump(game)}
    p "Game saved. Thanks for playing"
    return 'stop'
  end

  def choose_saved_game
    puts "Which game would you like to play?"
    puts "#{Dir.glob('*/*.yml').map{ |s| File.basename(s, ".yml")}.join(",\n")}"
    input = gets.chomp.downcase
    load_game(input)
  end

  def load_game(filename)
    file = File.open("saved_games/#{filename}.yml", "r")
    data = file.read
    f = YAML::safe_load(data, permitted_classes: [Game, Player, Bishop, Board, King, Knight, Pawn, Queen, Rook], aliases: true)
    puts "Welcome back, #{f.players[0]} and #{f.players[1]}."
    @board = f.board
    @current_player_id = f.current_player_id
    @players = f.players
    @pieces = f.pieces
    #@board.place_pieces

    File.delete("saved_games/#{filename}.yml")
  end

end