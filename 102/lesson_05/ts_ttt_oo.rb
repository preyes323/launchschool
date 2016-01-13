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

  describe '#top_left' do
    it 'must detect the current top_left coordinate allowed' do
      Square.top_left.must_equal [1, 1]
    end

    it 'must detect the current top_left coordinate allowed2' do
      sq1 = Square.new('x', [1, 0])
      Square.top_left.must_equal [1, 0]
    end

    it 'must detect the current top_left coordinate allowed3' do
      sq1 = Square.new('x', [1, 0])
      sq2 = Square.new('x', [2, 1])
      Square.top_left.must_equal [1, 0]
    end

    it 'must detect the current top_left coordinate allowed4' do
      sq1 = Square.new('x', [1, 0])
      sq2 = Square.new('x', [2, 1])
      sq3 = Square.new('x', [0, 0])
      Square.top_left.must_equal [0, 0]
    end
  end

  describe '#bottom_right' do
    it 'must detect the current bottom_right coordinate allowed' do
      Square.bottom_right.must_equal [1, 1]
    end

    it 'must detect the current bottom_right coordinate allowed2' do
      sq1 = Square.new('x', [1, 0])
      Square.bottom_right.must_equal [1, 1]
    end

    it 'must detect the current bottom_right coordinate allowed3' do
      sq1 = Square.new('x', [1, 0])
      sq2 = Square.new('x', [2, 1])
      Square.bottom_right.must_equal [2, 1]
    end

    it 'must detect the current bottom_right coordinate allowed4' do
      sq1 = Square.new('x', [1, 0])
      sq2 = Square.new('x', [2, 1])
      sq3 = Square.new('x', [0, 0])
      Square.bottom_right.must_equal [2, 1]
    end
  end
end

describe Neighborhood do
  before do
    @square = Square.new('x', [1, 1])
  end
end
