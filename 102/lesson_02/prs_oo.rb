class Player
  attr_reader :name

  def initialize(name = '')
    self.name = name
  end

  def name=(name)
    @name = name.rstrip.empty? ? 'NO_NAME' : name
  end

  def choose; end
end

class Move
  def initialize; end

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
