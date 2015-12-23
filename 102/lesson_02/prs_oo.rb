require 'colorize'
require 'yaml'
require 'pry'

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

class Move
  attr_reader :choice
  include Comparable

  MESSAGES = YAML.load_file('prs_messages.yml')
  MOVES = {r: '[R]ock', p: '[P]aper', s: '[S]cissors',
           l: '[L]izard', k: 'Spoc[k]'}

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
    return 0 if value  == other.value

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
    key = "#{Move.new(move1)}_#{Move.new(move2)}".tr('[]', '').downcase
    MESSAGES[key]
  end
end

class RPSGame
  def initialize
    @computer = Computer.new
    @human = Human.new(player_name)
  end

  def play
    @human.choose
    @computer.choose
    winner, looser = evalute_player_moves(@human, @computer)
    p Move.winning_message(winner.move.choice, looser.move.choice)
  end

  private

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
