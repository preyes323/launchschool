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

module Neighborhood
  @@top_left_limit = nil
  @@bottom_right_limit = nil

  def update_top_left_bottom_right(location)
    Neighborhood.top_left_limit ||= location
    Neighborhood.bottom_right_limit ||= location

    if location[0] <= Neighborhood.top_left_limit[0] &&
        location[1] <= Neighborhood.top_left_limit[1]
      Neighborhood.top_left_limit = location
    end

    if location[0] >= Neighborhood.bottom_right_limit[0] &&
       location[1] >= Neighborhood.bottom_right_limit[1]
      Neighborhood.bottom_right_limit = location
    end
  end

  def self.top_left_limit
    @@top_left_limit
  end

  def self.top_left_limit=(location)
    @@top_left_limit = location
  end

  def self.bottom_right_limit
    @@bottom_right_limit
  end

  def self.bottom_right_limit=(location)
    @@bottom_right_limit = location
  end
end

class Square
  include Neighborhood
  attr_reader :mark, :location

  def initialize(mark, location)
    unless valid_location?(location)
      fail ArgumentError, 'Square location must be an array of two numbers'
    end

    @mark = mark
    @location = location
    self.update_top_left_bottom_right(@location)
  end

  private

  def valid_location?(location)
    location.class == Array && location.length == 2
  end
end
