require 'minitest/spec'
require 'minitest/autorun'
require_relative 'prs_oo'

describe Player do
  NAMES = ['Hal', 'R2D2', 'Deep blue', 'C3P0']
  MOVES = {r: '[R]ock', p: '[P]aper', s: '[S]cissors',
           l: '[L]izard', k: 'Spoc[k]'}

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
      MOVES.values.must_include @computer_player.move.value
    end

    it 'must adjust its move based on human player moves' do
    end
  end
end

describe Move do
  describe 'when a move is initialized' do
    it 'must return nil if an invalid move is set' do
      Move.new('invalid move').value.must_be_nil
    end

    it 'must return valid move description for rock' do
      Move.new(:r).value.must_equal '[R]ock'
    end

    it 'must return valid move description for paper' do
      Move.new(:p).value.must_equal '[P]aper'
    end

    it 'must return valid move description for scissors' do
      Move.new(:s).value.must_equal '[S]cissors'
    end

    it 'must return valid move description for lizard' do
      Move.new(:l).value.must_equal '[L]izard'
    end

    it 'must return valid move description for spock' do
      Move.new(:k).value.must_equal 'Spoc[k]'
    end
  end

  describe 'when a move is compared' do
    it 'must return Rock > Scissors' do
      Move.new(:r).must_be :>, Move.new(:s)
    end

    it 'must return Rock > Lizard' do
      Move.new(:r).must_be :>, Move.new(:l)
    end

    it 'must return Paper > Rock' do
      Move.new(:p).must_be :>, Move.new(:r)
    end

    it 'must return Paper > Spock' do
      Move.new(:p).must_be :>, Move.new(:k)
    end

    it 'must return Scissors > Paper' do
      Move.new(:s).must_be :>, Move.new(:p)
    end

    it 'must return Scissors > Lizard' do
      Move.new(:s).must_be :>, Move.new(:l)
    end

    it 'must return Lizard > Spock' do
      Move.new(:l).must_be :>, Move.new(:k)
    end

    it 'must return Lizard > Paper' do
      Move.new(:l).must_be :>, Move.new(:p)
    end

    it 'must return Spock > Scissors' do
      Move.new(:k).must_be :>, Move.new(:s)
    end

    it 'must return Spock > Rock' do
      Move.new(:k).must_be :>, Move.new(:r)
    end
  end

  describe 'when message for comparison is asked' do
    it 'must display correct message when Rock and Scissors' do
      Move.winning_message(:r, :s).must_equal 'Rock crushes Scissors'
    end

    it 'must display correct message when Rock and Lizard' do
      Move.winning_message(:r, :l).must_equal 'Rock crushes Lizard'
    end

    it 'must display correct message when Paper and Rock' do
      Move.winning_message(:p, :r).must_equal 'Paper covers Rock'
    end

    it 'must display correct message when Paper and Spock' do
      Move.winning_message(:p, :k).must_equal 'Paper disproves Spock'
    end

    it 'must display correct message when Scissors and Paper' do
      Move.winning_message(:s, :p).must_equal 'Scissors cuts Paper'
    end

    it 'must display correct message when Scissors and Lizard' do
      Move.winning_message(:s, :l).must_equal 'Scissors decapitates Lizard'
    end

    it 'must display correct message when Lizard and Spock' do
      Move.winning_message(:l, :k).must_equal 'Lizard poisons Spock'
    end

    it 'must display correct message when Lizard and Paper' do
      Move.winning_message(:l, :p).must_equal 'Lizard eats Paper'
    end

    it 'must display correct message when Spock and Scissors' do
      Move.winning_message(:k, :r).must_equal 'Spock vaporizes Rock'
    end

    it 'must display correct message when Spock and Rock' do
      Move.winning_message(:k, :s).must_equal 'Spock smashes Scissors'
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
