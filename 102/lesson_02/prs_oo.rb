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
  MOVES = {r: '[R]ock', p: '[P]aper', s: '[S]cissors',
           l: '[L]izard', k: 'Spoc[k]'}

  def initialize(move)
    @move = move
  end

  def move
    MOVES[@move]
  end

  def to_s
    move
  end

  def self.compare(other)

  end
end

class RPSGame
  def initialize; end

  def play
    display_welcome_message
    human.move
    computer.move
    display_winner
    display_goodbye_message
  end
end
