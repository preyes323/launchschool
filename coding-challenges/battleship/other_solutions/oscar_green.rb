# creates board for each player
class Player
  attr_reader :board, :name
  def initialize(name)
    @board = Board.new
    @name = name
  end
end

# creates the board
class Board
  attr_accessor :spots, :b_hash, :ships, :ship_locations

  def initialize
    create_spots
    @ships = Ship.new
    @ship_locations = [ships.battleship_loc, ships.cruiser_loc, ships.destroyer_loc]
  end

  def create_spots
    @spots = (1..5).to_a.product((1..5).to_a)
    @b_hash = {}
    spots.each do |x|
      @b_hash[x] = ' '
    end
  end

  def draw_board
    arr = (1..5).to_a
    line = '  +---+---+---+---+---+'
    header = '    1   2   3   4   5'

    puts header
    arr.each do |num|
      puts line
      puts "#{num} | #{b_hash[[1, num]]} | #{b_hash[[2, num]]} | #{b_hash[[3, num]]} | #{b_hash[[4, num]]} | #{b_hash[[5, num]]} |"
    end

    puts line
    puts ''
    puts "#{ships.destroyer[:name]}: #{ships.destroyer[:status]}   #{ships.cruiser[:name]}: #{ships.cruiser[:status]}   #{ships.battleship[:name]}: #{ships.battleship[:status]} "
    puts ''
  end

  def check_hit(loc)
    ship_locations.each do |x|
      x.each do |y|
        if loc == y
          b_hash[loc] = 'X'
          check_ship_status
          return nil
        end
      end
      b_hash[loc] = '/'
    end
  end

  def check_ship_status
    ships.battleship[:status] = 'Dead' if b_hash[ships.battleship_loc[0]] == 'X' && b_hash[ships.battleship_loc[1]] == 'X' && b_hash[ships.battleship_loc[1]] == 'X'
    ships.cruiser[:status] = 'Dead' if b_hash[ships.cruiser_loc[0]] == 'X' && b_hash[ships.cruiser_loc[1]] == 'X'
    ships.destroyer[:status] = 'Dead' if b_hash[ships.destroyer_loc[0]] == 'X'
  end

  def check_lost
    if ships.cruiser[:status] == 'Dead' && ships.destroyer[:status] == 'Dead' && ships.battleship[:status] == 'Dead'
      return true
    end
    false
  end
end

# creates ships and places in locations
class Ship
  attr_accessor :battleship_loc, :cruiser_loc, :destroyer_loc, :battleship, :destroyer, :cruiser

  def initialize
    place_ships
    @battleship = { status: 'Alive', name: 'Battleship' }
    @cruiser = { status: 'Alive', name: 'Cruiser' }
    @destroyer = { status: 'Alive', name: 'Destroyer' }
  end

  def place_ships
    possibles = []
    self.cruiser_loc = []
    (1..5).each do |x|
      (1..5).each_cons(3) { |y| possibles << [x].product(y) }
    end
    self.battleship_loc = possibles.delete(possibles.sample)
    self.cruiser_loc = possibles.delete(possibles.sample)
    self.cruiser_loc = cruiser_loc.each_cons(2).to_a.sample
    self.destroyer_loc = possibles.delete(possibles.sample)
    self.destroyer_loc = destroyer_loc.each_cons(1).to_a.sample
  end
end

# implements game engine
class Game
  attr_reader :player, :computer, :computer_play
  attr_accessor :current_player

  def initialize
    @player = Player.new('Johnny Arcade')
    @computer = Player.new('R2D2')
    @computer_play = (1..5).to_a.product((1..5).to_a)
    @current_player = player
  end

  def show_boards
    system 'clear'
    player.board.draw_board
    computer.board.draw_board
  end

  def player_moves(c_board)
    puts 'Please select a square (such as 3, 5) to open fire!'
    loop do
      selection = gets.chomp
      if selection[0].to_i == 0 || selection[1] != ',' || selection[2] != ' ' || selection[3] .to_i == 0 || selection.size > 4
        puts 'INVALID FORMAT, TRY AGAIN'
      elsif selection[0].to_i > 5 || selection[0].to_i < 1 || selection[3].to_i > 5 || selection[3].to_i < 1
        puts 'OUT OF RANGE, TRY AGAIN'
      elsif c_board.b_hash[[selection[0].to_i, selection[3].to_i]] != ' '
        puts 'NOT AN EMPTY SQUARE, TRY AGAIN'
      else
        c_board.check_hit([selection[0].to_i, selection[3].to_i])
        break
      end
    end
  end

  def computer_moves(p_board)
    move = computer_play.delete(computer_play.sample)
    p_board.check_hit(move)
  end

  def someone_won?(p_board, c_board)
    if c_board.check_lost
      puts "Congratulations #{player.name} has won game!"
      return true
    elsif p_board.check_lost
      puts "#{computer.name} has won the game!"
      return true
    else
      return false
    end
  end

  def play
    show_boards
    loop do
      player_moves(computer.board)
      show_boards
      computer_moves(player.board)
      show_boards
      break if someone_won?(player.board, computer.board)
    end
  end
end

game = Game.new
game.play
