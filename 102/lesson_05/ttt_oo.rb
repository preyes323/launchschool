require 'yaml'
require 'pry'

CONFIG = YAML.load_file('ttt_config.yml')

class Marker
  attr_reader :symbol, :owner

  def initialize(symbol, owner)
    if symbol.length > CONFIG['allowed_marker_length']
      raise ArgumentError, 'Symbol exceeds allowed length'
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
  attr_accessor :collection

  def initialize
    self.collection = []
  end

  def each(&block)
    return collection.each unless block
    collection.each { |item| block.call(item) }
  end

  def <<(marker)
    if symbol_exists?(marker) || owner_exists?(marker)
      raise ArgumentError, 'Symbol and owner must be unique'
    end

    collection.push marker
  end

  def []=(idx, obj)
    raise ArgumentError, 'Symbol is in use' if symbol_exists?(obj)
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
  NEIGHBORHOOD_DEPTH = 2
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

  def self.current(mark, location, board)
    board.square_at(location).mark == mark ? 1 : 0
  end

  module Vertical
    def self.score_for(mark, location, board)
      return 0 unless board.square_at(location)
      (top(mark, location, board) +
       bottom(mark, location, board) +
       Neighborhood.current(mark, location, board))
    end

    def self.top(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] - (offset + 1), location[1]]
        break if new_location[0] < Neighborhood.top_left_limit[0]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end

    def self.bottom(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] + (offset + 1), location[1]]
        break if new_location[0] > Neighborhood.bottom_right_limit[0]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end
  end

  module Horizontal
    def self.score_for(mark, location, board)
      return 0 unless board.square_at(location)
      (left(mark, location, board) +
       right(mark, location, board) +
       Neighborhood.current(mark, location, board))
    end

    def self.left(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0], location[1] - (offset + 1)]
        break if new_location[1] < Neighborhood.top_left_limit[1]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end

    def self.right(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0], location[1] + (offset + 1)]
        break if new_location[1] > Neighborhood.bottom_right_limit[1]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end
  end

  module RightDiag
    def self.score_for(mark, location, board)
      return 0 unless board.square_at(location)
      (upper_left(mark, location, board) +
       lower_right(mark, location, board) +
       Neighborhood.current(mark, location, board))
    end

    def self.upper_left(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] - (offset + 1),
                        location[1] - (offset + 1)]
        break if new_location[1] < Neighborhood.top_left_limit[1]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end

    def self.lower_right(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] + (offset + 1),
                        location[1] + (offset + 1)]
        break if new_location[1] > Neighborhood.bottom_right_limit[1]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end
  end

  module LeftDiag
    def self.score_for(mark, location, board)
      return 0 unless board.square_at(location)
      (upper_right(mark, location, board) +
       lower_left(mark, location, board) +
       Neighborhood.current(mark, location, board))
    end

    def self.upper_right(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] - (offset + 1),
                        location[1] + (offset + 1)]
        break if new_location[1] > Neighborhood.bottom_right_limit[1] ||
                 new_location[0] < Neighborhood.top_left_limit[0]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end

    def self.lower_left(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] + (offset + 1),
                        location[1] - (offset + 1)]
        break if new_location[1] < Neighborhood.top_left_limit[1] ||
                 new_location[0] > Neighborhood.bottom_right_limit[0]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end
  end
end

class Board
  attr_accessor :squares, :neighborhood_depth

  def initialize(game_type = 'regular')
    build_board(CONFIG[game_type]['board_size'])
    self.neighborhood_depth = CONFIG[game_type]['neighborhood_depth']
  end

  def update_square_at(location, marker)
    square_at(location).mark = marker if square_at(location)
  end

  def square_at(location)
    squares.select { |square| square.location == location }[0]
  end

  def draw_board
    board = ''
    size = (squares.count**(0.5)).to_i

    size.times do |row|
      board << draw_top_row(size) if row == 0
      board << draw_top_bottom_cell(size)
      board << draw_middle_cell(row, size)
    end

    board << draw_top_bottom_cell(size).chomp
  end

  private

  def draw_marker(row, col)
    "#{square_at([row, col]).mark.center(3, ' ')}"
  end

  def draw_top_row(cols)
    result = ''

    cols.times do |col|
      result << (col == 0 ? "    #{col}" : "   #{col}")
    end

    result << "\n"
  end

  def draw_top_bottom_cell(cols)
    result = ''

    cols.times do |col|
      result << case col
                when 0 then '  +---'
                when cols - 1 then "+---+\n"
                else '+---'
                end
    end

    result
  end

  def draw_middle_cell(row, cols)
    result = ''

    cols.times do |col|
      result << case col
                when 0 then "#{row} |#{draw_marker(row, col)}"
                when cols - 1 then "|#{draw_marker(row, col)}|\n"
                else "|#{draw_marker(row, col)}"
                end
    end

    result
  end

  def build_board(size)
    self.squares = []
    size.times do |row|
      size.times { |col| self.squares << Square.new('', [row, col]) }
    end
  end
end

class Square
  include Neighborhood
  attr_reader :location
  attr_accessor :mark

  def initialize(mark, location)
    unless valid_location?(location)
      raise ArgumentError, 'Square location must be an array of two numbers'
    end

    @mark = mark
    @location = location
    self.update_top_left_bottom_right(@location)
  end

  def to_s
    mark
  end

  private

  def valid_location?(location)
    location.class == Array && location.length == 2
  end
end

class Player
  attr_accessor :name

  def initialize(name = 'NO_NAME')
    self.name = name
  end

  def to_s
    "#{name}"
  end
end

class Human < Player
  def move

  end

  def valid_move?(move)
    move.class == Array &&
    move.length == 2    &&
    move.all? { |input| input =~ /\d/ }
  end
end
