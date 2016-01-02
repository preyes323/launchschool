# There are 2 players both having their own board of 5*5 squares.
# Each board has 3 ships. Each taking 1,2, or 3 squares.
# Player selects a square to shoot. If it has a ship, mark x. Else mark /.
# Player who sinks all ships first wins.

# Refactoring todo
# Make 3 subclasses for different ships. Have a method in there to show status of ship

class Board
  attr_reader :sq

  def initialize

    @sq = {}
    x = 1
    y = 1

    loop do
      loop do
        @sq[[x,y]] = " "

        y += 1
        break if y == 6
      end

      y = 1
      x += 1
      break if x == 6
    end

  end

  def empty_sq
    @sq.select { |_k, v| v == ' ' }.keys
  end

  def hit_sq
    @sq.select { |_k, v| v == 'X' }.keys
  end

  def display
    puts '    1   2   3   4   5  '
    puts '  +---+---+---+---+---+'
    puts "1 | #{sq[[1,1]]} | #{sq[[1,2]]} | #{sq[[1,3]]} | #{sq[[1,4]]} | #{sq[[1,5]]} |"
    puts '  +---+---+---+---+---+'
    puts "2 | #{sq[[2,1]]} | #{sq[[2,2]]} | #{sq[[2,3]]} | #{sq[[2,4]]} | #{sq[[2,5]]} |"
    puts '  +---+---+---+---+---+'
    puts "3 | #{sq[[3,1]]} | #{sq[[3,2]]} | #{sq[[3,3]]} | #{sq[[3,4]]} | #{sq[[3,5]]} |"
    puts '  +---+---+---+---+---+'
    puts "4 | #{sq[[4,1]]} | #{sq[[4,2]]} | #{sq[[4,3]]} | #{sq[[4,4]]} | #{sq[[4,5]]} |"
    puts '  +---+---+---+---+---+'
    puts "5 | #{sq[[5,1]]} | #{sq[[5,2]]} | #{sq[[5,3]]} | #{sq[[5,4]]} | #{sq[[5,5]]} |"
    puts '  +---+---+---+---+---+'
  end

end

class Ship
  attr_accessor :unused

  def initialize
    x = 1
    y = 1
    grid = []

    loop do
      loop do
        grid << [x,y]

        y += 1
        break if y == 6
      end

      y = 1
      x += 1
      break if x == 6
    end

    @unused = grid
  end

  def destroyer
    destroyer = []
    destroyer << @unused.sample

    destroyer.each do |cell|
      @unused.delete(cell)
    end

    destroyer
  end

  def cruiser
    cruiser_placements = []

    @unused.each do |sq|
      x = sq[0]
      y = sq[1]

      if @unused.include?([x,y+1])
        cruiser_placements << [[x,y],[x,y+1]]
      end

      if @unused.include?([x+1,y])
        cruiser_placements << [[x,y],[x+1,y]]
      end
    end

    cruiser = cruiser_placements.sample

    cruiser.each do |cell|
      @unused.delete(cell)
    end

    cruiser

  end

  def battleship

    battleship_placements = []

    @unused.each do |sq|
      x = sq[0]
      y = sq[1]

      if @unused.include?([x,y+1]) && @unused.include?([x,y+2])
        battleship_placements << [[x,y],[x,y+1],[x,y+2]]
      end

      if @unused.include?([x+1,y]) && @unused.include?([x+2,y])
        battleship_placements << [[x,y],[x+1,y],[x+2,y]]
      end
    end

    battleship = battleship_placements.sample

    battleship.each do |cell|
      @unused.delete(cell)
    end

    battleship

  end

end

module Markable
  def mark_on_board(sq)
    if @destroyer.include?(sq) || @cruiser.include?(sq) || @battleship.include?(sq)
      @board.sq[sq] = "X"
    else
      @board.sq[sq] = "/"
    end
  end
end

class Player
  attr_accessor :name, :board, :ship, :destroyer, :cruiser, :battleship
  include Markable

  def initialize(name)
    @name = name
    @board = Board.new

    @ship = Ship.new
    @destroyer = ship.destroyer
    @cruiser = ship.cruiser
    @battleship = ship.battleship
  end

  def mark
    puts "Please type a square (such as 3,5) to open fire:"
    player_marks = gets.chomp
    sq = player_marks.split(',').map(&:to_i)
    mark_on_board(sq)
  end

  def automark
    sq = @board.empty_sq.sample
    mark_on_board(sq)
  end

end

class BattleshipGame
  def initialize
    @player = Player.new("John")
    @computer = Player.new("R2D2")

  end

  def sunk?(ship)
    ship == ship & @player.board.hit_sq
  end

  def co_sunk?(ship)
    ship == ship & @computer.board.hit_sq
  end

  def display_winner
    if sunk?(@player.destroyer) && sunk?(@player.cruiser) && sunk?(@player.battleship)
      puts "#{@player.name} wins!"
    elsif co_sunk?(@computer.destroyer) && co_sunk?(@computer.cruiser) && co_sunk?(@computer.battleship)
      puts "#{@computer.name} wins!"
    else
      puts ""
    end
  end

  def display_sunk_player
    @player_destroyer = "Alive"
    @player_cruiser = "Alive"
    @player_battleship = "Alive"

    if sunk?(@player.destroyer)
      @player_destroyer = "Sunk"
    end
    if sunk?(@player.cruiser)
      @player_cruiser = "Sunk"
    end
    if sunk?(@player.battleship)
      @player_battleship = "Sunk"
    end

    puts "Destroyer: #{@player_destroyer} | Cruiser: #{@player_cruiser} | Battleship: #{@player_battleship}"

  end

  def display_sunk_computer
    @computer_destroyer = "Alive"
    @computer_cruiser = "Alive"
    @computer_battleship = "Alive"

    if co_sunk?(@computer.destroyer)
      @computer_destroyer = "Sunk"
    end
    if co_sunk?(@computer.cruiser)
      @computer_cruiser = "Sunk"
    end
    if co_sunk?(@computer.battleship)
      @computer_battleship = "Sunk"
    end

    puts "Destroyer: #{@computer_destroyer} | Cruiser: #{@computer_cruiser} | Battleship: #{@computer_battleship}"
  end

  def display
    system 'clear'
    puts "#{@player.name}'s board:"
    @player.board.display
    display_sunk_player
    puts ""
    puts "#{@computer.name}'s board:"
    @computer.board.display
    display_sunk_computer

    display_winner
  end

  def play
    display
    p @player.destroyer
    p @player.cruiser
    p @player.battleship

    loop do
      @player.mark
      @computer.automark
      display
      break if (sunk?(@player.destroyer) && sunk?(@player.cruiser) && sunk?(@player.battleship)) || (co_sunk?(@computer.destroyer) && co_sunk?(@computer.cruiser) && co_sunk?(@computer.battleship))
    end

  end
end

BattleshipGame.new.play
