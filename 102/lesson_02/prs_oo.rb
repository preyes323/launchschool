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
      Move::MOVES.each { |idx, move| "#{idx.inspect}: #{move}" }
      choice = gets.chomp.downcase.to_sym
      @move = Move.new(choice)
      break unless move
    end
  end
end

class Computer < Player
  NAMES = ['Hal', 'R2D2', 'Deep blue', 'C3P0']

  def initialize
    @name = NAMES.sample
  end

  def choose
    @move = Move.new(MOVE.moves.values.sample)
  end
end

class Move
  include Comparable
  attr_writer :move

  MOVES = {r: '[R]ock', p: '[P]aper', s: '[S]cissors',
           l: '[L]izard', k: 'Spoc[k]'}

  def initialize(move)
    self.move = move
  end

  def move
    MOVES[@move]
  end

  def to_s
    move
  end

  def <=>(other)
    return 0 if move  == other.move
    case move
    when '[R]ock'
      other.move == '[S]cissors' || other.move == '[L]izard' ?  1 : - 1
    when '[P]aper'
      other.move == 'Spoc[k]'    || other.move == '[R]ock'   ?  1 : - 1
    when '[S]cissors'
      other.move == '[P]aper'    || other.move == '[L]izard' ?  1 : - 1
    when '[L]izard'
      other.move == '[P]aper'    || other.move == 'Spoc[k]'  ?  1 : - 1
    when 'Spoc[k]'
      other.move == '[S]cissors' || other.move == '[R]ock'   ?  1 : - 1
    end
  end

  def self.winning_message(move1, move2)
  end
end

class RPSGame
  def initialize
    @computer = Computer.new
    @player = player_name
  end

  def play

    human.move
    computer.move
    display_winner

  end

  private

  def player_name
    print "What is your name? "
    gets.chomp
  end
end
