#----------------------------------------------
# battleship.rb
# BATTLESHIP GAME
#
# Two player game between a human and a computer. The objective is to find
# and destroy all the opposing players ships.
#----------------------------------------------

require 'pry'
require 'colorize'
require 'yaml'

class Player
  attr_reader :name, :move

  def initialize(name = '')
    self.name = name
  end

  def name=(name)
    @name = name.rstrip.empty? ? 'NO_NAME' : name
  end

  def choose; end

  def ships; end

  def position_ships; end
end

class Human < Player

  def choose; end

  def position_ships; end
end

class Computer < Player
  NAMES = ['Hal', 'R2D2', 'Deep blue', 'C3P0']

  def initialize
    @name = NAMES.sample
  end

  def choose; end

  def position_ships; end
end

class Ship
  attr_accessor :hitpoints, :type

  def initialize(type)
    self.type = type
    self.hitpoints = initialize_hitpoints(type)
  end

  def to_s
    "#{type}: #{hitpoints}"
  end

  private

  def initialize_hitpoints(type)
    case type
    when 'destroyer' then 1
    when 'cruiser' then 2
    when 'battleship' then 3
    else 0
    end
  end
end

class Board
  attr_accessor :board, :markers

  def initialize(*sides)
    @board = ''
    @rows = sides[0]
    @cols = sides[1] ? sides[1] : sides[0]
    self.markers = Array.new(@rows) { Array.new(@cols) }
    build_board(@rows, @cols)
  end

  def mark!(row, col, marker)
    valid_row_col?(row, col) ? !!place(row - 1, col - 1, marker) : false
  end

  def update!
    @board = ''
    build_board(@rows, @cols)
  end

  def display_board
    puts "#{board}"
  end

  def to_s
    "#{board}"
  end

  private

  def valid_row_col?(row, col)
    row <= @rows && col <= @cols && row > 0 && col > 0
  end

  def place(row, col, marker)
    markers[row][col].nil? ? self.markers[row][col] = marker : false
  end

  def build_board(rows, cols)
    rows.times do |row|
      self.board << draw_top_row(cols) if row == 0
      self.board << draw_top_bottom_cell(cols)
      self.board << draw_middle_cell(row, cols)
    end
    self.board << draw_top_bottom_cell(cols).chomp
  end

  def draw_marker(row, col)
    "#{markers[row][col].to_s.center(3, ' ')}"
  end

  def draw_top_row(cols)
    result = ''

    cols.times do |col|
      result << (col == 0 ? "    #{(col + 1)}" : "   #{(col + 1)}")
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
                when 0 then "#{row + 1} |#{draw_marker(row, col)}"
                when cols - 1 then "|#{draw_marker(row, col)}|\n"
                else "|#{draw_marker(row, col)}"
                end
    end

    result
  end
end

# board = Board.new(5)

# board.display_board
# puts board
