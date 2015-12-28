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
  attr_accessor :board, :location_marks

  def initialize(*sides)
    @board = ''
    if sides.length == 2
      self.location_marks = Array.new(sides[0]) { Array.new(sides[1]) }
      build_board(sides[0], sides[1])
    else
      self.location_marks = Array.new(sides[0]) { Array.new(sides[0]) }
      build_board(sides[0], sides[0])
    end
  end

  def display_board

  end

  def to_s

  end

  private

  def build_board(rows, cols)
    rows.times do |row|
      self.board << draw_top_row(cols) if row == 0
      self.board << draw_top_bottom_cell(cols)
      self.board << draw_middle_cell(row, cols)
    end
    self.board << draw_top_bottom_cell(cols).chomp
  end

  def draw_marker(row, col)
    "#{location_marks[row][col].to_s.center(3, ' ')}"
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
                when cols - 1 then "|#{draw_marker(row - 1, col - 1)}|\n"
                else "|#{draw_marker(row, col)}"
                end
    end

    result
  end
end
