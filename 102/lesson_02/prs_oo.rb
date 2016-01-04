require 'colorize'
require 'yaml'
require 'pry'

MESSAGES = YAML.load_file('prs_messages.yml')

class Player
  attr_reader :name, :move

  def initialize(name = '')
    self.name = name
  end

  def name=(name)
    @name = name.rstrip.empty? ? 'NO_NAME' : name
  end

  def choose; end
end

class Human < Player
  def choose
    loop do
      puts 'Choose a move:'
      puts Weapon.display_options
      print "=> "
      choice = gets.chomp.to_i - 1
      @move = Move.new(Weapon.options[choice].to_s)
      break if Weapon.options[choice]
    end
  end
end

class Computer < Player
  NAMES = ['Hal', 'R2D2', 'Deep blue', 'C3P0']

  def initialize
    @name = NAMES.sample
  end

  def choose
    @move = Move.new(Weapon.options.sample.to_s)
  end
end

module Statisticable
  attr_accessor :data, :players
end

class DummyStatistics
  include Statisticable

  def initialize
    @human = Human.new
    @computer = Computer.new
    self.players = [@human, @computer]
    self.data = {}
  end
end

class Weapon
  attr_reader :beats, :loses_to

  def self.options
    ObjectSpace.each_object(Class)
      .select { |klass| klass < self }
      .each.sort_by(&:name)
  end

  def self.display_options
    options.map.with_index { |opt, idx| "#{idx + 1}: #{opt}" }.join("\n")
  end

  def name
    "#{self.class}"
  end

  def to_s
    name
  end
end

class Rock < Weapon
  def initialize
    @beats = %w(Scissors Lizard)
    @loses_to = %w(Spock Paper)
  end
end

class Paper < Weapon
  def initialize
    @beats = %w(Rock Spock)
    @loses_to = %w(Lizard Scissors)
  end
end

class Scissors < Weapon
  def initialize
    @beats = %w(Paper Lizard)
    @loses_to = %w(Rock Spock)
  end
end

class Spock < Weapon
  def initialize
    @beats = %w(Rock Scissors)
    @loses_to = %w(Paper Lizard)
  end
end

class Lizard < Weapon
  def initialize
    @beats = %w(Spock Paper)
    @loses_to = %w(Scissors Rock)
  end
end

class Move
  include Comparable
  attr_reader :choice

  def initialize(move)
    @choice = Weapon.options[Weapon.options.map(&:to_s).index(move)].new
  end

  def value
    choice.class
  end

  def to_s
    choice.name
  end

  def <=>(other)
    return 0 if value == other.value

    choice.beats.include?(other.to_s) ? 1 : -1
  end

  def self.winning_message(move1, move2)
    key = if move1 == move2
            'tie'
          else
            "#{Move.new(move1)}_#{Move.new(move2)}".downcase
          end
    MESSAGES[key]
  end
end

class RPSGame
  attr_accessor :players

  def initialize
    display_welcome_screen
    @computer = Computer.new
    @human = Human.new(player_name)
    self.players = player_order(@human, @computer)
  end

  def play
    loop do
      system 'clear' || system('cls')
      display_game_board(players[0], players[1])

      players.each(&:choose)
      winner, looser = evalute_player_moves(@human, @computer)

      system 'clear' || system('cls')
      display_game_board(players[0], players[1])
      p Move.winning_message(winner.move.to_s, looser.move.to_s)

      break unless play_again?
    end
  end

  private

  def display_welcome_screen
    system 'clear' || system('cls')
    puts MESSAGES['welcome']
    puts ''
    sleep 5
  end

  def display_game_board(player1, player2)
    board = %(+------------------+------------------+
|#{player1.name.center(18, ' ')}|#{player2.name.center(18, ' ')}|
+------------------+------------------+
|                  |                  |
|#{player1.move.to_s.center(18, ' ')}|#{player2.move.to_s.center(18, ' ')}|
|                  |                  |
+------------------+------------------+)
    puts board
  end

  def play_again?
    print "Do you want to have another go against #{@computer.name} (y/n)? "
    gets.chomp.downcase == 'y'
  end

  def player_order(*players)
    players.shuffle!
  end

  def player_name
    print "What is your name? "
    gets.chomp
  end

  def evalute_player_moves(player1, player2)
    if player1.move > player2.move
      winner = player1
      looser = player2
    else
      winner = player2
      looser = player1
    end
    [winner, looser]
  end
end

# RPSGame.new.play

# puts Weapon.options
