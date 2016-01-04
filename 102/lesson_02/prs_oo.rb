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
      Move::MOVES.each { |idx, move| puts "#{idx.inspect}: #{move}" }
      print "=> "
      choice = gets.chomp.downcase.to_sym
      @move = Move.new(choice)
      break if move.value
    end
  end
end

class Computer < Player
  NAMES = ['Hal', 'R2D2', 'Deep blue', 'C3P0']

  def initialize
    @name = NAMES.sample
  end

  def choose
    @move = Move.new(Move::MOVES.keys.sample)
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
    ObjectSpace.each_object(Class).select { |klass| klass < self }.each
  end

  def self.display_options
    options.sort_by(&:name)
      .map.with_index { |opt, idx| "#{idx + 1}: #{opt}" }
      .join("\n")
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
  attr_reader :choice
  include Comparable

  MOVES = { r: '[R]ock', p: '[P]aper', s: '[S]cissors',
            l: '[L]izard', k: 'Spoc[k]' }

  def initialize(move)
    @choice = move
  end

  def value
    MOVES[@choice]
  end

  def to_s
    value
  end

  def <=>(other)
    return 0 if value == other.value

    case value
    when '[R]ock'
      other.value == '[S]cissors' || other.value == '[L]izard' ?  1 : - 1
    when '[P]aper'
      other.value == 'Spoc[k]'    || other.value == '[R]ock'   ?  1 : - 1
    when '[S]cissors'
      other.value == '[P]aper'    || other.value == '[L]izard' ?  1 : - 1
    when '[L]izard'
      other.value == '[P]aper'    || other.value == 'Spoc[k]'  ?  1 : - 1
    when 'Spoc[k]'
      other.value == '[S]cissors' || other.value == '[R]ock'   ?  1 : - 1
    end
  end

  def self.winning_message(move1, move2)
    key = if move1 == move2
            'tie'
          else
            "#{Move.new(move1)}_#{Move.new(move2)}".tr('[]', '').downcase
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
      p Move.winning_message(winner.move.choice, looser.move.choice)

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

RPSGame.new.play

# puts Weapon.options
