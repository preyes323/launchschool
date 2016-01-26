require 'minitest/spec'
require 'minitest/autorun'
require_relative 'ttt_oo'

describe Marker do
  before do
    @marker = Marker.new('p', 'Paolo')
  end

  describe '#initialize' do
    it 'must create a marker with the mark provided' do
      @marker.mark.must_equal 'p'
    end

    it 'must create a marker with the owner provided' do
      @marker.owner.must_equal 'Paolo'
    end

    it 'must raise an error if marker symobl exceeds length allowed' do
      proc { Marker.new('xxx', 'Paolo') }.must_raise ArgumentError
    end
  end

  describe '#to_s' do
    it 'must display the owner & mark when Marker is converted to string' do
      "#{@marker}".must_equal 'Paolo: p'
    end
  end

  describe '#==' do
    it 'must catch that marker mark matches other marker mark' do
      @marker.must_be :==, Marker.new('p', 'Paolo')
    end

    it 'must catch that marker mark does not match other marker mark' do
      @marker.must_be :!=, Marker.new('d', 'Paolo')
    end
  end
end

describe Markers do
  before do
    @markers = Markers.new
    @marker = Marker.new('p', 'Paolo')
    @rachelle = Human.new
    @marker2 = Marker.new('r', @rachelle)
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

    it 'must raise an error if marker mark is already in use' do
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

  describe '#marks' do
    it 'must return an array of marks for markers' do
      @markers << @marker
      @markers << Marker.new('r', 'Rachelle')
      marks = %w(p r)
      @markers.marks.must_equal marks
    end
  end

  describe '#marker_of' do
    it 'must return the marker of the owner specified' do
      @markers << @marker2
      @markers.marker_of(@rachelle).must_equal @marker2
    end
  end

  describe '#other_than' do
    it 'must return all markers that are not equal to the mark' do
      @markers << @marker
      @markers << @marker2
      other_markers = ['p', 'r'].sort
      @markers.other_than('x').sort.must_equal other_markers
    end

    it 'must return all markers that are not equal to the mark' do
      @markers << @marker
      @markers << @marker2
      @markers << Marker.new('s', 'Raine')
      other_markers = ['p', 'r'].sort
      @markers.other_than('s').sort.must_equal other_markers
    end
  end

  describe '#[]=' do
    it 'must store the marker mark in the array' do
      @collection[0] = @marker
      @markers[0] = @marker
      @markers.collection.must_equal @collection
    end

    it 'must overwrite the mark if the owner exists' do
      @collection[0] = @marker
      @collection[0] = Marker.new('r', 'Paolo')

      @markers[0] = @marker
      @markers[0] = Marker.new('r', 'Paolo')

      @markers.collection.must_equal @collection
    end

    it 'must fail when assigning an existing mark' do
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
    it 'must return the mark that is tagged on the square' do
      @square.mark.must_equal 'x'
    end
  end

  describe '#to_s' do
    it 'must return the marker mark' do
      @square.to_s.must_equal 'x'
    end
  end
end

describe Board do
  before do
    @board = Board.new
  end

  describe '#square_at' do
    it 'must return the square at a given location' do
      @board.square_at([1, 1]).must_be_instance_of Square
    end

    it 'must return nil if there is no square at the given location' do
      @board.square_at([2, 7]).must_be_nil
    end
  end

  describe '#update_square_at' do
    it 'must update the marker of the square at a given location' do
      @board.update_square_at([1, 1], 'y')
      @board.square_at([1, 1]).mark.must_equal 'y'
    end

    it 'must return nil if square to update does not exist' do
      @board.update_square_at([2, 7], 'y').must_be_nil
    end
  end

  describe '#new' do
    it 'must create a new empty board for the default game (3x3)' do
      @board.squares.count.must_equal 9
    end
  end

  describe '#empty_square?' do
    it 'must return true if the square at the location is empty' do
      assert @board.empty_square?([1, 1])
    end

    it 'must return false if the square at the location is not empty' do
      @board.update_square_at([1, 1], 'x')
      refute @board.empty_square?([1, 1])
    end
  end

  describe '#empty_squares' do
    it 'must return an array of empty squares' do
      @board.empty_squares.must_be_instance_of Array
    end
    it 'must return all unmarked/empty squares in the board' do
      @board.empty_squares.count.must_equal 9
    end

    it 'must return all unmarked/empty squares in the board_2' do
      @board.update_square_at([1, 1], 'y')
      @board.update_square_at([1, 2], 'x')
      @board.empty_squares.count.must_equal 7
    end
  end

  describe '#empty_squares_location' do
    it 'must return the location of all squares that are empty' do
      @board.update_square_at([0, 1], 'y')
      @board.update_square_at([0, 2], 'x')
      @board.update_square_at([0, 0], 'y')
      @board.update_square_at([1, 1], 'x')
      @board.update_square_at([1, 2], 'y')
      @board.update_square_at([2, 2], 'x')
      @board.update_square_at([2, 1], 'y')
      @board.update_square_at([2, 0], 'x')
      @board.empty_squares_location.must_equal [[1, 0]]
    end
  end

  describe '#draw' do
    it 'must return the string representation of a board with empty sqaures' do
      board_output = %(    0   1   2
  +---+---+---+
0 |   |   |   |
  +---+---+---+
1 |   |   |   |
  +---+---+---+
2 |   |   |   |
  +---+---+---+).chomp
      @board.draw.must_equal board_output
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
      @board.update_square_at([1, 1], 'x')
      @board.update_square_at([2, 2], 'o')
      @board.draw.must_equal board_output
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

  describe '#win_on_next_square' do
    it 'must flag the square to win on next move given a marker' do
      board = Board.new
      square = board.square_at([0, 1])
      board.update_square_at([0, 0], 'x')
      board.update_square_at([0, 1], 'x')
      winning_square = board.square_at([0, 2])
      square.win_on_next_square('x', board).must_equal winning_square
    end

    it 'must flag the square to win on next move given a marker_2' do
      board = Board.new
      square = board.square_at([0, 2])
      board.update_square_at([0, 0], 'x')
      board.update_square_at([0, 1], 'x')
      winning_square = nil
      square.win_on_next_square('y', board).must_equal winning_square
    end

    it 'must flag the square to win on next move given a marker_3' do
      board = Board.new
      square = board.square_at([1, 1])
      board.update_square_at([0, 0], 'x')
      board.update_square_at([0, 1], 'x')
      board.update_square_at([1, 1], 'x')
      board.update_square_at([2, 2], 'x')
      winning_square = board.square_at([2, 1])
      square.win_on_next_square('x', board).must_equal winning_square
    end

    it 'must flag the square to win on next move given a marker_4' do
      board = Board.new
      square = board.square_at([1, 1])
      board.update_square_at([0, 0], 'x')
      board.update_square_at([1, 1], 'x')
      winning_square = board.square_at([2, 2])
      square.win_on_next_square('x', board).must_equal winning_square
    end
  end

  describe '#score_for' do
    it 'must return the total neigborhood score for a square' do
      board = Board.new
      square = board.square_at([1, 1])
      square.score_for('x', board).must_equal 0
    end

    it 'must return the total neigborhood score for a square_2' do
      board = Board.new
      square = board.square_at([1, 1])
      board.update_square_at([0, 0], 'x')
      board.update_square_at([0, 1], 'y')
      square.score_for('x', board).must_equal 1
    end

    it 'must return the total neigborhood score for a square_3' do
      board = Board.new
      square = board.square_at([1, 1])
      board.update_square_at([0, 0], 'x')
      board.update_square_at([0, 1], 'x')
      square.score_for('x', board).must_equal 2
    end

    it 'must return the total neigborhood score for a square_3' do
      board = Board.new
      square = board.square_at([1, 0])
      board.update_square_at([0, 0], 'x')
      board.update_square_at([0, 1], 'x')
      square.score_for('x', board).must_equal 2
    end

    it 'must return the total neigborhood score for a square_3' do
      board = Board.new
      square = board.square_at([1, 1])
      board.update_square_at([0, 0], 'x')
      board.update_square_at([0, 1], 'x')
      board.update_square_at([1, 1], 'x')
      square.score_for('x', board).must_equal 6
    end
  end
end

describe Neighborhood::Vertical do
  before do
    Neighborhood.top_left_limit = nil
    Neighborhood.bottom_right_limit = nil
    @board = Board.new
    @board.update_square_at([1, 1], 'x')
    @neighborhood = Neighborhood::Vertical
  end

  describe '#score_for' do
    it "must return correct score given neighborhood squares 'marker'" do
      @neighborhood.score_for('x', [1, 1], @board).must_equal 1
    end

    it "must return correct score given neighborhood squares 'marker'_2" do
      @board.update_square_at([1, 1], 'y')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 0
    end

    it "must return correct score given neighborhood squares 'marker'_3" do
      @board.update_square_at([0, 1], 'x')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 2
    end

    it "must return correct score given neighborhood squares 'marker'_4" do
      @board.update_square_at([0, 1], 'x')
      @board.update_square_at([0, 2], 'x')
      @board.update_square_at([2, 1], 'x')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 3
    end

    it "must return correct score given neighborhood squares @corner" do
      @board.update_square_at([0, 0], 'x')
      @board.update_square_at([1, 0], 'x')
      @board.update_square_at([2, 0], 'x')
      @neighborhood.score_for('x', [0, 0], @board).must_equal 2
    end

    it 'must return 0 if the square location does not exist' do
      @neighborhood.score_for('x', [-1, 0], @board).must_equal 0
    end

    it 'must return correct score with bigger board' do
      board = Board.new('expert')
      board.update_square_at([0, 0], 'x')
      board.update_square_at([1, 0], 'x')
      board.update_square_at([2, 0], 'x')
      @neighborhood.score_for('x', [0, 0], board).must_equal 3
    end

    it 'must return correct score with bigger board_2' do
      board = Board.new('expert')
      board.update_square_at([0, 0], 'x')
      board.update_square_at([1, 0], 'x')
      board.update_square_at([2, 0], 'x')
      @neighborhood.score_for('x', [2, 0], board).must_equal 3
    end

    it 'must return correct score with bigger board_2' do
      board = Board.new('expert')
      board.update_square_at([0, 0], 'x')
      board.update_square_at([1, 0], 'x')
      board.update_square_at([2, 0], 'x')
      board.update_square_at([3, 0], 'y')
      board.update_square_at([4, 0], 'x')
      @neighborhood.score_for('x', [2, 0], board).must_equal 4
    end
  end

  describe '#empty_neighbors_for' do
    it 'must return the empty squares for the given location' do
      board = Board.new
      square1 = board.square_at([0, 0])
      square2 = board.square_at([2, 0])
      empty_squares = [square1, square2]
      @neighborhood.empty_neighbors_for([1, 0], board).must_equal empty_squares
    end

    it 'must return the empty squares for the given location_2' do
      board = Board.new
      board.update_square_at([0, 0], 'x')
      square2 = board.square_at([2, 0])
      empty_squares = [square2]
      @neighborhood.empty_neighbors_for([1, 0], board).must_equal empty_squares
    end
  end
end

describe Neighborhood::Horizontal do
  before do
    Neighborhood.top_left_limit = nil
    Neighborhood.bottom_right_limit = nil
    @board = Board.new
    @board.update_square_at([1, 1], 'x')
    @neighborhood = Neighborhood::Horizontal
  end

  describe '#score' do
    it "must return correct score given neighborhood squares 'marker'" do
      @neighborhood.score_for('x', [1, 1], @board).must_equal 1
    end

    it "must return correct score given neighborhood squares 'marker'_2" do
      @board.update_square_at([1, 1], 'y')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 0
    end

    it "must return correct score given neighborhood squares 'marker'_3" do
      @board.update_square_at([1, 2], 'x')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 2
    end

    it "must return correct score given neighborhood squares 'marker'_4" do
      @board.update_square_at([1, 2], 'x')
      @board.update_square_at([0, 2], 'x')
      @board.update_square_at([1, 0], 'x')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 3
    end
  end

  describe '#empty_neighbors_for' do
    it 'must return the empty squares for the given location' do
      board = Board.new
      square1 = board.square_at([0, 1])
      empty_squares = [square1]
      @neighborhood.empty_neighbors_for([0, 0], board).must_equal empty_squares
    end

    it 'must return the empty squares for the given location_2' do
      board = Board.new
      square1 = board.square_at([0, 0])
      square2 = board.square_at([0, 2])
      empty_squares = [square1, square2]
      @neighborhood.empty_neighbors_for([0, 1], board).must_equal empty_squares
    end
  end
end

describe Neighborhood::RightDiag do
  before do
    Neighborhood.top_left_limit = nil
    Neighborhood.bottom_right_limit = nil
    @board = Board.new
    @board.update_square_at([1, 1], 'x')
    @neighborhood = Neighborhood::RightDiag
  end

  describe '#score' do
    it "must return correct score given neighborhood squares 'marker'" do
      @neighborhood.score_for('x', [1, 1], @board).must_equal 1
    end

    it "must return correct score given neighborhood squares 'marker'_2" do
      @board.update_square_at([1, 1], 'y')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 0
    end

    it "must return correct score given neighborhood squares 'marker'_3" do
      @board.update_square_at([0, 0], 'x')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 2
    end

    it "must return correct score given neighborhood squares 'marker'_4" do
      @board.update_square_at([0, 0], 'x')
      @board.update_square_at([0, 2], 'x')
      @board.update_square_at([2, 2], 'x')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 3
    end

    it 'must return correct score given corner square' do
      @board.update_square_at([0, 1], 'x')
      @neighborhood.score_for('x', [1, 2], @board).must_equal 1
    end
  end

  describe '#empty_neighbors_for' do
    it 'must return the empty squares for the given location' do
      board = Board.new
      square1 = board.square_at([1, 1])
      empty_squares = [square1]
      @neighborhood.empty_neighbors_for([0, 0], board).must_equal empty_squares
    end

    it 'must return the empty squares for the given location_2' do
      board = Board.new
      square1 = board.square_at([0, 0])
      square2 = board.square_at([2, 2])
      empty_squares = [square1, square2]
      @neighborhood.empty_neighbors_for([1, 1], board).must_equal empty_squares
    end

    it 'must return the empty squares for the given location_2' do
      board = Board.new
      board.update_square_at([1, 1], 'x')
      board.update_square_at([0, 0], 'x')
      square2 = board.square_at([2, 2])
      empty_squares = [square2]
      @neighborhood.empty_neighbors_for([1, 1], board).must_equal empty_squares
    end
  end
end

describe Neighborhood::LeftDiag do
  before do
    Neighborhood.top_left_limit = nil
    Neighborhood.bottom_right_limit = nil
    @board = Board.new
    @board.update_square_at([1, 1], 'x')
    @neighborhood = Neighborhood::LeftDiag
  end

  describe '#score' do
    it "must return correct score given neighborhood squares 'marker'" do
      @neighborhood.score_for('x', [1, 1], @board).must_equal 1
    end

    it "must return correct score given neighborhood squares 'marker'_2" do
      @board.update_square_at([1, 1], 'y')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 0
    end

    it "must return correct score given neighborhood squares 'marker'_3" do
      @board.update_square_at([0, 2], 'x')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 2
    end

    it "must return correct score given neighborhood squares 'marker'_4" do
      @board.update_square_at([0, 1], 'x')
      @board.update_square_at([0, 2], 'x')
      @board.update_square_at([2, 0], 'x')
      @neighborhood.score_for('x', [1, 1], @board).must_equal 3
    end

    it 'must return correct score given corner square' do
      @board.update_square_at([2, 0], 'x')
      @neighborhood.score_for('x', [2, 0], @board).must_equal 2
    end
  end

  describe '#empty_neighbors_for' do
    it 'must return the empty squares for the given location' do
      board = Board.new
      square1 = board.square_at([1, 1])
      empty_squares = [square1]
      @neighborhood.empty_neighbors_for([0, 2], board).must_equal empty_squares
    end

    it 'must return the empty squares for the given location_2' do
      board = Board.new
      square2 = board.square_at([2, 1])
      empty_squares = [square2]
      @neighborhood.empty_neighbors_for([1, 2], board).must_equal empty_squares
    end
  end
end

describe Player do
  before do
    @player = Player.new
  end

  describe '#new' do
    it 'must default to name = NO_NAME if non provided' do
      @player.name.must_equal 'NO_NAME'
    end

    it 'must create a player with the name provided' do
      player = Player.new('Paolo')
      player.name.must_equal 'Paolo'
    end
  end
end

describe Human do
  before do
    @human = Human.new
    @board = Board.new
  end

  describe '#valid_move?' do
    it 'must return true if the human player input a valid move' do
      assert @human.valid_move?(%w(1 1))
    end

    it 'must return false if the human player input an invalid move' do
      refute  @human.valid_move?(%w(a 1))
    end

    it 'must return false if the human player input an invalid move_2' do
      refute @human.valid_move?('x')
    end

    it 'must return false if the human player input an invalid move_2' do
      refute @human.valid_move?(%w(1))
    end
  end

  describe '#valid_location?' do
    it 'must return true if the chosen location is not currently marked' do
      assert @human.valid_location?([1, 1], @board)
    end

    it 'must return false if the chosen location is currently marked' do
      @board.update_square_at([1, 1], 'y')
      refute @human.valid_location?([1, 1], @board)
    end
  end
end

describe Computer do
  before do
    Neighborhood.top_left_limit = nil
    Neighborhood.bottom_right_limit = nil
    @computer_names = CONFIG['computer_names']
    @computer = Computer.new
    @markers = Markers.new
    @marker = Marker.new('x', 'Paolo')
    @markers << @marker
    @board = Board.new
  end

  describe '#new' do
    it 'must only have a name based on the valid choices' do
      @computer_names.must_include @computer.name
    end
  end

  describe '#choose_marker' do
    it 'must add a marker that is not yet part of the marker collection' do
      @computer.choose_marker(@markers)
      @markers.count.must_equal 2
    end
  end

  describe '#winning_move' do
    it 'must return a square that will make the computer win' do
      @computer.choose_marker(@markers)
      mark = @markers.marker_of(@computer).mark
      @board.update_square_at([1, 1], mark)
      @board.update_square_at([0, 1], mark)
      winning_square = [@board.square_at([2, 1])]
      @computer.winning_move(@board, @markers).must_equal winning_square
    end

    it 'must return nil when no square will make the computer win' do
      @computer.choose_marker(@markers)
      mark = @markers.marker_of(@computer).mark
      @board.update_square_at([1, 1], mark)
      assert @computer.winning_move(@board, @markers).empty?
    end
  end

  describe '#opponents_winning_move' do
    it 'must catch a sqaure that will make other markers win' do
      @computer.choose_marker(@markers)
      mark = @markers.marker_of(@computer).mark
      @board.update_square_at([0, 0], 'x')
      @board.update_square_at([1, 1], 'x')
      squares = [@board.square_at([2, 2])]
      @computer.opponents_winning_move(@board, @markers).must_equal squares
    end

    it 'must catch a sqaure that will make other markers win_2' do
      @computer.choose_marker(@markers)
      mark = @markers.marker_of(@computer).mark
      @board.update_square_at([0, 0], 'x')
      @board.update_square_at([1, 1], 'x')
      @board.update_square_at([1, 0], 'x')
      square2 = @board.square_at([2, 0])
      square3 = @board.square_at([1, 2])
      squares = [square2, square3]
      @computer.opponents_winning_move(@board, @markers).must_equal squares
    end

    it 'must return empty array if no other marker has a winning move' do
      @computer.choose_marker(@markers)
      mark = @markers.marker_of(@computer).mark
      @board.update_square_at([1, 1], 'x')
      assert @computer.opponents_winning_move(@board, @markers).empty?
    end

    it 'must catch a sqaure that will make other markers win_3' do
      @computer.choose_marker(@markers)
      @markers << Marker.new('y', 'Raine')
      mark = @markers.marker_of(@computer).mark
      @board.update_square_at([0, 0], 'x')
      @board.update_square_at([1, 0], 'x')
      @board.update_square_at([0, 2], 'y')
      @board.update_square_at([1, 2], 'y')
      square1 = @board.square_at([2, 2])
      square2 = @board.square_at([2, 0])
      squares = [square2, square1]
      @computer.opponents_winning_move(@board, @markers).must_equal squares
    end
  end

  describe '#high_value_squares' do
    it 'must return squares with highest values' do
      @computer.choose_marker(@markers)
      @markers << Marker.new('y', 'Raine')
      mark = @markers.marker_of(@computer).mark
      @board.update_square_at([2, 0], mark)
      @board.update_square_at([1, 2], mark)
      square1 = @board.square_at([1, 1])
      square2 = @board.square_at([2, 1])
      squares = [square1, square2]
      @computer.high_value_squares(@board, @markers).must_equal squares
    end
  end

  describe '#move' do
    it 'must return the appropriate move given the board squares' do
      @computer.choose_marker(@markers)
      @markers << Marker.new('y', 'Raine')
      mark = @markers.marker_of(@computer).mark
      @board.update_square_at([1, 1], mark)
      @board.update_square_at([1, 0], 'x')
      @board.update_square_at([2, 0], mark)
      @board.update_square_at([0, 2], 'x')
      square1 = @board.square_at([2, 2])
      square2 = @board.square_at([2, 1])
      squares = [square1, square2]
      squares.must_include @computer.move(@board, @markers)
    end
  end
end
