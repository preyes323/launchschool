require 'yaml'
require 'pry'

class Marker
  ALLOWED_LENGTH = 1
  attr_reader :symbol, :owner

  def initialize(symbol, owner)
    if symbol.length > ALLOWED_LENGTH
      fail ArgumentError, 'Symbol exceeds allowed length'
    end

    @symbol = symbol
    @owner = owner
  end

  def to_s
    "#{owner}: #{symbol}"
  end

  def ==(other)
    symbol == other.symbol
  end
end

class Markers
  include Enumerable
  attr_reader :collection

  def initialize
    @collection = []
  end

  def each(&block)
    return collection.each unless block
    collection.each { |item| block.call(item) }
  end

  def <<(marker)
    if symbol_exists?(marker) || owner_exists?(marker)
      fail ArgumentError, 'Symbol and owner must be unique'
    end

    collection.push marker
  end

  def []=(idx, obj)
    fail ArgumentError, 'Symbol is in use' if symbol_exists?(obj)
    collection[idx] = obj
  end

  def [](idx)
    collection[idx]
  end

  def owners
    collection.map(&:owner)
  end

  def symbols
    collection.map(&:symbol)
  end

  def symbol_exists?(marker)
    symbols.include? marker.symbol
  end

  def owner_exists?(marker)
    owners.include? marker.owner
  end

  def to_s
    collection.map do |marker|
      [marker.owner, marker.symbol]
    end
  end
end

class Square
  attr_reader :mark, :location

  def initialize(mark, location)
    unless valid_location?(location)
      fail ArgumentError, 'Square location must be an array of two numbers'
    end
    @mark = mark
    @location = location
  end

  private

  def valid_location?(location)
    location.class == Array && location.length == 2
  end
end
