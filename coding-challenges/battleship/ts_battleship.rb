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
  before do
    @board = Board.new(5)
  end

  describe 'when creating a new board' do
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
      @board.board.must_equal board_5x5
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

  describe 'when updating an existing board' do
    it 'must mark a blank board position with a marker' do
      assert @board.mark!(5, 5, 'x')
    end

    it 'must mark a blank board position with a marker 2' do
      assert @board.mark!(3, 2, 'x')
    end

    it 'must not mark a board position that does not exist' do
      refute @board.mark!(6, 6, 'x')
    end

    it 'must not mark a taken board position with the same marker' do
      @board.mark!(5, 5, 'x')
      refute @board.mark!(5, 5, 'x')
    end

    it 'must not mark a taken board position with a different marker' do
      @board.mark!(5, 5, 'x')
      refute @board.mark!(5, 5, '/')
    end

    it 'must display marked board correctly' do
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
5 |   |   |   |   | x |
  +---+---+---+---+---+
).chomp
      @board.mark!(5, 5, 'x')
      @board.update!
      @board.board.must_equal board_5x5
    end

    it 'must display marked board correctly 2' do
      board_5x5 = %(    1   2   3   4   5
  +---+---+---+---+---+
1 |   |   |   |   |   |
  +---+---+---+---+---+
2 |   |   |   |   |   |
  +---+---+---+---+---+
3 |   | x |   |   |   |
  +---+---+---+---+---+
4 |   |   |   |   |   |
  +---+---+---+---+---+
5 |   |   |   |   |   |
  +---+---+---+---+---+
).chomp
      @board.mark!(3, 2, 'x')
      @board.update!
      @board.board.must_equal board_5x5
    end

    it 'must display multiple marked board correctly' do
      board_5x5 = %(    1   2   3   4   5
  +---+---+---+---+---+
1 |   |   |   |   |   |
  +---+---+---+---+---+
2 | / |   |   |   |   |
  +---+---+---+---+---+
3 |   | x |   |   | x |
  +---+---+---+---+---+
4 |   |   |   |   |   |
  +---+---+---+---+---+
5 |   |   |   |   |   |
  +---+---+---+---+---+
).chomp
      @board.mark!(3, 2, 'x')
      @board.mark!(2, 1, '/')
      @board.mark!(3, 5, 'x')
      @board.update!
      @board.board.must_equal board_5x5
    end
  end

  describe 'when adding a ship to the board' do
    it 'must return false when adding an invalid ship' do
      refute @board.add_ship('jet', [3, 1], [1, 2])
    end

    it 'must return true when adding a valid ship' do
      assert @board.add_ship('destroyer', [1, 1], [1, 1])
    end

    it 'must not allow a ship to be placed on an invalid location' do
      refute @board.add_ship('destroyer', [5, 6], [1, 2])
    end

    it 'must return false if ship dimension does not match coordinates' do
      refute @board.add_ship('battleship', [1, 4], [2, 4])
    end

    it 'must return true if ship dimension matches coordinates' do
      assert @board.add_ship('battleship', [1, 4], [3, 4])
    end

    it 'must return true when adding a ship not in excess of allowed type' do
      assert @board.add_ship('destroyer', [1, 1], [1, 1])
    end

    it 'must return false when adding a ship in excess of allowed type' do
      @board.add_ship('destroyer', [1, 4], [1, 4])
      refute @board.add_ship('destroyer', [1, 4], [1, 4])
    end

    it 'must return true if able to randomly add a battleship' do
      assert @board.random_add_ship('battleship')
    end

    it 'must return true if able to randomly add a carrier' do
      assert @board.random_add_ship('carrier')
    end

    it 'must return false if not able to randomly add to a full board' do
      @board.markers = Array.new(5) { Array.new(5, 'x') }
      refute @board.random_add_ship('destroyer')
    end

    it 'must allow adding ship that does not occupy same space as existing' do
      @board.add_ship('battleship', [2, 2], [2, 4])
      assert @board.add_ship('battleship', [3, 2], [3, 4])
    end

    it 'must not allow a ship to occupy the same space as an existing ship1' do
      @board.add_ship('battleship', [2, 2], [2, 4])
      refute @board.add_ship('destroyer', [2, 3], [2, 3])
    end

    it 'must not allow a ship to occupy the same space as an existing ship2' do
      @board.add_ship('battleship', [2, 2], [2, 4])
      refute @board.add_ship('battleship', [1, 3], [3, 3])
    end

    it 'must allow all ships to be added randomly' do
      assert @board.random_add_all_ships
    end
  end
end
