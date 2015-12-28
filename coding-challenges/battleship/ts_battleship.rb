require 'minitest/spec'
require 'minitest/autorun'
require_relative 'battleship'

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
end

describe Ship do
  describe 'when creating a new ship' do
    it 'must have 1 hitpoint if destroyer' do
      Ship.new('destroyer').hitpoints.must_equal 1
    end

    it 'must have 2 hitpoints if cruiser' do
      Ship.new('cruiser').hitpoints.must_equal 2
    end

    it 'must have 3 hitpoints if battleship' do
      Ship.new('battleship').hitpoints.must_equal 3
    end
  end

  describe 'when printing out display of Ship details (to_s)' do
    it 'must have valid shipname and hitpoint amount' do
      Ship.new('cruiser').to_s
                         .must_match /cruiser|destroyer|battleship|:\s[0-3]/
    end
  end
end

describe Board do
  describe 'when create a new board' do
    it 'must successfully create an empty 5x5 board' do
      board_5x5 = %(    1   2   3   4   5
  +---+---+---+---+---+
1 |   |   |   |   |   |
  +---+---+---+---+---+
2 |   |   |   |   |   |
  +---+---+---+---+---+
3 |   |   |   |   |   |
  +---+---+---+---+---+
4 |   |   |   |   |   |
  +---+---+---+---+---+
5 |   |   |   |   |   |
  +---+---+---+---+---+
).chomp

      Board.new(5).board.must_equal board_5x5
    end

    it 'must successfully create an empty 5x7 board' do
      board_5x7 = %(    1   2   3   4   5   6   7
  +---+---+---+---+---+---+---+
1 |   |   |   |   |   |   |   |
  +---+---+---+---+---+---+---+
2 |   |   |   |   |   |   |   |
  +---+---+---+---+---+---+---+
3 |   |   |   |   |   |   |   |
  +---+---+---+---+---+---+---+
4 |   |   |   |   |   |   |   |
  +---+---+---+---+---+---+---+
5 |   |   |   |   |   |   |   |
  +---+---+---+---+---+---+---+
).chomp
      Board.new(5, 7).board.must_equal board_5x7
    end
  end
end
