require 'minitest/spec'
require 'minitest/autorun'
require_relative 'prs_oo'

describe Player do
  NAMES = ['Hal', 'R2D2', 'Deep blue', 'C3P0']

  before do
    @human_player = Human.new
    @computer_player = Computer.new
  end

  describe 'when asked for a human player name' do
    it 'must be NO_NAME' do
      @human_player.name.must_equal 'NO_NAME'
    end

    it 'must be equal to initialized name' do
      name_provided = 'Paolo'
      Player.new('Paolo').name.must_equal name_provided
    end

    it 'must be equal to the set name' do
      set_name = 'Paolo'
      @human_player.name = set_name
      @human_player.name.must_equal set_name
    end
  end

  describe 'when setting a computer player name' do
    it 'must be included in NAMES choices' do
      NAMES.must_include @computer_player.name
    end
  end

  describe 'when computer chooses a move' do
    it 'must select a valid move' do
      @computer_player.choose
      Weapon.options.must_include @computer_player.move.value
    end

    it 'must adjust its move based on human player moves' do
    end
  end
end

describe Move do
  describe 'when a move is initialized' do
    it 'must return correct weapon class for rock' do
      Move.new('Rock').value.must_equal Rock
    end

    it 'must return correct weapon class for paper' do
      Move.new('Paper').value.must_equal Paper
    end

    it 'must return correct weapon class for scissors' do
      Move.new('Scissors').value.must_equal Scissors
    end

    it 'must return correct weapon class for lizard' do
      Move.new('Lizard').value.must_equal Lizard
    end

    it 'must return correct weapon class for spock' do
      Move.new('Spock').value.must_equal Spock
    end
  end

  describe 'when a move is compared' do
    it 'must detect if moves are the same' do
      Move.new('Rock').must_be :==, Move.new('Rock')
    end

    it 'must return Rock > Scissors' do
      Move.new('Rock').must_be :>, Move.new('Scissors')
    end

    it 'must return Rock > Lizard' do
      Move.new('Rock').must_be :>, Move.new('Lizard')
    end

    it 'must return Paper > Rock' do
      Move.new('Paper').must_be :>, Move.new('Rock')
    end

    it 'must return Paper > Spock' do
      Move.new('Paper').must_be :>, Move.new('Spock')
    end

    it 'must return Scissors > Paper' do
      Move.new('Scissors').must_be :>, Move.new('Paper')
    end

    it 'must return Scissors > Lizard' do
      Move.new('Scissors').must_be :>, Move.new('Lizard')
    end

    it 'must return Lizard > Spock' do
      Move.new('Lizard').must_be :>, Move.new('Spock')
    end

    it 'must return Lizard > Paper' do
      Move.new('Lizard').must_be :>, Move.new('Paper')
    end

    it 'must return Spock > Scissors' do
      Move.new('Spock').must_be :>, Move.new('Scissors')
    end

    it 'must return Spock > Rock' do
      Move.new('Spock').must_be :>, Move.new('Rock')
    end
  end

  describe 'when message for comparison is asked' do
    it 'must display correct message when Rock and Scissors' do
      Move.winning_message('Rock', 'Scissors').must_equal 'Rock crushes Scissors'
    end

    it 'must display correct message when Rock and Lizard' do
      Move.winning_message('Rock', 'Lizard').must_equal 'Rock crushes Lizard'
    end

    it 'must display correct message when Paper and Rock' do
      Move.winning_message('Paper', 'Rock').must_equal 'Paper covers Rock'
    end

    it 'must display correct message when Paper and Spock' do
      Move.winning_message('Paper', 'Spock').must_equal 'Paper disproves Spock'
    end

    it 'must display correct message when Scissors and Paper' do
      Move.winning_message('Scissors', 'Paper').must_equal 'Scissors cuts Paper'
    end

    it 'must display correct message when Scissors and Lizard' do
      Move.winning_message('Scissors', 'Lizard').must_equal 'Scissors decapitates Lizard'
    end

    it 'must display correct message when Lizard and Spock' do
      Move.winning_message('Lizard', 'Spock').must_equal 'Lizard poisons Spock'
    end

    it 'must display correct message when Lizard and Paper' do
      Move.winning_message('Lizard', 'Paper').must_equal 'Lizard eats Paper'
    end

    it 'must display correct message when Spock and Scissors' do
      Move.winning_message('Spock', 'Rock').must_equal 'Spock vaporizes Rock'
    end

    it 'must display correct message when Spock and Rock' do
      Move.winning_message('Spock', 'Scissors').must_equal 'Spock smashes Scissors'
    end
  end
end

describe Weapon do
  describe 'when getting options' do
    it 'must have options' do
      assert Weapon.options
    end

    it 'must display options for weapons in the following manner' do
      options = %(1: Lizard
2: Paper
3: Rock
4: Scissors
5: Spock)
      Weapon.display_options.must_equal options
    end
  end
end

describe Paper do
  before do
    @paper = Paper.new
  end

  describe 'when an instance is created' do
    it 'must know its name' do
      @paper.name.must_equal 'Paper'
    end

    it 'must know what it beats' do
      @paper.beats.must_equal %w(Rock Spock)
    end

    it 'must know what it loses to' do
      @paper.loses_to.must_equal %w(Lizard Scissors)
    end
  end
end

describe Rock do
  before do
    @rock = Rock.new
  end

  describe 'when an instance is created' do
    it 'must know its name' do
      @rock.name.must_equal 'Rock'
    end

    it 'must know what it beats' do
      @rock.beats.must_equal %w(Scissors Lizard)
    end

    it 'must know what it loses to' do
      @rock.loses_to.must_equal %w(Spock Paper)
    end
  end
end

describe Scissors do
  before do
    @scissors = Scissors.new
  end

  describe 'when an instance is created' do
    it 'must know its name' do
      @scissors.name.must_equal 'Scissors'
    end

    it 'must know what it beats' do
      @scissors.beats.must_equal %w(Paper Lizard)
    end

    it 'must know what it loses to' do
      @scissors.loses_to.must_equal %w(Rock Spock)
    end
  end
end

describe Spock do
  before do
    @spock = Spock.new
  end

  describe 'when an instance is created' do
    it 'must know its name' do
      @spock.name.must_equal 'Spock'
    end

    it 'must know what it beats' do
      @spock.beats.must_equal %w(Rock Scissors)
    end

    it 'must know what it loses to' do
      @spock.loses_to.must_equal %w(Paper Lizard)
    end
  end
end

describe Lizard do
  before do
    @lizard = Lizard.new
  end

  describe 'when an instance is created' do
    it 'must know its name' do
      @lizard.name.must_equal 'Lizard'
    end

    it 'must know what it beats' do
      @lizard.beats.must_equal %w(Spock Paper)
    end

    it 'must know what it loses to' do
      @lizard.loses_to.must_equal %w(Scissors Rock)
    end
  end
end

describe Statisticable do
  before do
    @human = Human.new
    @computer = Computer.new
  end

  describe 'when a move is made' do
    it 'must increment the move a human player made' do
    end

    it 'must increment the move a computer player made' do
    end
  end

  describe 'when a player wins' do
    it 'must record the win' do
    end

    it 'must match the win to the move' do
    end

    it 'must match the win to the move to the winning player' do
    end
  end

  describe 'when a report is requested' do
    it 'must suggest a ratio of moves for winning' do
    end

    it 'must display history of moves' do
    end
  end
end
