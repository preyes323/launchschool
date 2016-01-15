require 'minitest/spec'
require 'minitest/autorun'
require_relative 'ttt_oo'

describe Marker do
  before do
    @marker = Marker.new('p', 'Paolo')
  end

  describe '#initialize' do
    it 'must create a marker with the symbol provided' do
      @marker.symbol.must_equal 'p'
    end

    it 'must create a marker with the owner provided' do
      @marker.owner.must_equal 'Paolo'
    end

    it 'must raise an error if marker symobl exceeds length allowed' do
      proc { Marker.new('xxx', 'Paolo') }.must_raise ArgumentError
    end
  end

  describe '#to_s' do
    it 'must display the owner & symbol when Marker is converted to string' do
      "#{@marker}".must_equal 'Paolo: p'
    end
  end

  describe '#==' do
    it 'must catch that marker symbol matches other marker symbol' do
      @marker.must_be :==, Marker.new('p', 'Paolo')
    end

    it 'must catch that marker symbol does not match other marker symbol' do
      @marker.must_be :!=, Marker.new('d', 'Paolo')
    end
  end
end

describe Markers do
  before do
    @markers = Markers.new
    @marker = Marker.new('p', 'Paolo')
    @collection = []
  end

  describe '#initialize' do
    it 'must have an initial empty collection' do
      @markers.collection.must_be_empty
    end
  end

  describe '#<<' do
    it 'must add to the marker collection' do
      @collection <<  @marker

      @markers << @marker
      @markers.collection.must_equal @collection
    end

    it 'must add another  marker collection' do
      @collection << @marker
      another_marker = Marker.new('r', 'Rachelle')
      @collection << another_marker

      @markers << @marker
      @markers << another_marker
      @markers.collection.must_equal @collection
    end

    it 'must raise an error if marker symbol is already in use' do
      @markers << @marker
      proc { @markers << Marker.new('p', 'Rachelle') }.must_raise ArgumentError
    end

    it 'must raise an error if owner already has existing marker' do
      @markers << @marker
      proc { @markers << Marker.new('r', 'Paolo') }.must_raise ArgumentError
    end
  end

  describe '#owners' do
    it 'must return an array of owners for markers' do
      @markers << @marker
      @markers << Marker.new('r', 'Rachelle')
      owners = %w(Paolo Rachelle)
      @markers.owners.must_equal owners
    end
  end

  describe '#symbols' do
    it 'must return an array of symbols for markers' do
      @markers << @marker
      @markers << Marker.new('r', 'Rachelle')
      symbols = %w(p r)
      @markers.symbols.must_equal symbols
    end
  end

  describe '#[]=' do
    it 'must store the marker symbol in the array' do
      @collection[0] = @marker
      @markers[0] = @marker

      @markers.collection.must_equal @collection
    end

    it 'must overwrite the symbol if the owner exists' do
      @collection[0] = @marker
      @collection[0] = Marker.new('r', 'Paolo')

      @markers[0] = @marker
      @markers[0] = Marker.new('r', 'Paolo')

      @markers.collection.must_equal @collection
    end

    it 'must fail when assigning an existing symbol' do
      @markers << @marker
      proc do
        @markers[@markers.collection.length] = Marker.new('p', 'Rachelle')
      end.must_raise ArgumentError
    end
  end

  describe '#[]' do
    it 'must return the marker for the index provided' do
      @markers << @marker
      @markers[0].must_equal @marker
    end

    it 'must return nil if the index provided has not been assigned' do
      @markers[1].must_be_nil
    end
  end

  describe '#to_s' do
    it 'must return an array of markers [[marker, owner], [marker, owner]]' do
      collection = [['Paolo', 'p'], ['Rachelle', 'r']]
      @markers << @marker
      @markers << Marker.new('r', 'Rachelle')
      @markers.to_s.must_equal collection
    end
  end

  describe '#each' do
    it 'must return an enumerator' do
      @markers << @marker
      @markers.each.must_be_instance_of Enumerator
    end
  end
end

describe Square do
  before do
    Neighborhood.bottom_right_limit = nil
    Neighborhood.top_left_limit = nil
    @square = Square.new('x', [1, 1])
  end

  describe '#new' do
    it "must create a square with an 'x' mark on location [1, 1]" do
      assert @square
    end

    it 'must raise an error if location is not a [row, column] coordinate' do
      proc { Square.new('x', 1) }.must_raise ArgumentError
    end
  end

  describe '#location' do
    it 'must return the (row, column) coorinate of the square' do
      @square.location.must_equal [1, 1]
    end
  end

  describe '#mark' do
    it 'must return the symbol-mark that is tagged on the square' do
      @square.mark.must_equal 'x'
    end
  end

  describe '#to_s' do
    it 'must return the marker symbol' do
      @square.to_s.must_equal 'x'
    end
  end
end

describe Board do
  before do
    @board = Board.new
    @square = Square.new('', [1, 1])
  end

  describe '#<<' do
    it 'must add a square to the board' do
      @board << @square
      @board.count.must_equal 1
    end
  end

  describe '#[]' do
    it 'must return the square given the index' do
      @board << @square
      @board[-1].must_equal @square
    end
  end

  describe '#[]=' do
    it 'must assign the square to the index provided' do
      @board[0] = @square
      @board[0].must_equal @square
    end
  end

  describe '#square_at' do
    it 'must return the square at a given location' do
      @board << @square
      @board.square_at([1, 1]).must_equal @square
    end
  end

  describe '#update_square_at' do
    it 'must the marker of the square at a given location' do
      @board << @square
      @board.update_square_at([1, 1], 'y')
      @board.square_at([1, 1]).mark.must_equal 'y'
    end
  end

  describe '#new' do
    it 'must create a new empty board' do
      assert @board.empty?
    end

    it 'must create a new empty board with custom dimension' do
      board = Board.new(3)
      board.count.must_equal 9
    end
  end

  describe '#draw_board' do
    it 'must return the string representation of a board with empty sqaures' do
      board_output = %(    0   1   2
  +---+---+---+
0 |   |   |   |
  +---+---+---+
1 |   |   |   |
  +---+---+---+
2 |   |   |   |
  +---+---+---+).chomp
      board = Board.new(3)
      board.draw_board.must_equal board_output
    end

    it 'must return the string representation of a board with non-empty sq' do
      board_output = %(    0   1   2
  +---+---+---+
0 |   |   |   |
  +---+---+---+
1 |   | x |   |
  +---+---+---+
2 |   |   | o |
  +---+---+---+).chomp
      board = Board.new(3)
      board.update_square_at([1, 1], 'x')
      board.update_square_at([2, 2], 'o')
      board.draw_board.must_equal board_output
    end
  end
end


describe Neighborhood do
  before do
    Neighborhood.bottom_right_limit = nil
    Neighborhood.top_left_limit = nil
    @square = Square.new('x', [1, 1])
  end

  describe '#top_left_limit' do
    it 'must detect the current top_left_limit coordinate allowed' do
      Neighborhood.top_left_limit.must_equal [1, 1]
    end

    it 'must detect the current top_left_limit coordinate allowed2' do
      sq1 = Square.new('x', [1, 0])
      Neighborhood.top_left_limit.must_equal [1, 0]
    end

    it 'must detect the current top_left_limit coordinate allowed3' do
      sq1 = Square.new('x', [1, 0])
      sq2 = Square.new('x', [2, 1])
      Neighborhood.top_left_limit.must_equal [1, 0]
    end

    it 'must detect the current top_left_limit coordinate allowed4' do
      sq1 = Square.new('x', [1, 0])
      sq2 = Square.new('x', [2, 1])
      sq3 = Square.new('x', [0, 0])
      Neighborhood.top_left_limit.must_equal [0, 0]
    end
  end

  describe '#bottom_right_limit' do
    it 'must detect the current bottom_right_limit coordinate allowed' do
      Neighborhood.bottom_right_limit.must_equal [1, 1]
    end

    it 'must detect the current bottom_right_limit coordinate allowed2' do
      sq1 = Square.new('x', [1, 0])
      Neighborhood.bottom_right_limit.must_equal [1, 1]
    end

    it 'must detect the current bottom_right_limit coordinate allowed3' do
      sq1 = Square.new('x', [1, 0])
      sq2 = Square.new('x', [2, 1])
      Neighborhood.bottom_right_limit.must_equal [2, 1]
    end

    it 'must detect the current bottom_right_limit coordinate allowed4' do
      sq1 = Square.new('x', [1, 0])
      sq2 = Square.new('x', [2, 1])
      sq3 = Square.new('x', [0, 0])
      Neighborhood.bottom_right_limit.must_equal [2, 1]
    end
  end
end

describe Neighborhood::Vertical do
  before do
    @board = Board.new(3)
    @board.update_square_at([1, 1], 'x')
  end

  describe '#score' do
    it "must return correct score given neighborhood squares 'marker'" do
      Neighborhood::Vertical.score_for('x', [1, 1], @board).must_equal 1
    end
  end
end
