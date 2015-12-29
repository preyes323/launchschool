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

CONFIG = YAML.load_file('battleship_config.yml')

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
  attr_accessor :hitpoints, :type, :coordinates

  def initialize(type)
    self.type = type
    self.hitpoints = initialize_hitpoints(type)
  end

  def to_s
    "#{type}: #{hitpoints}"
  end

  private

  def initialize_hitpoints(type)
    CONFIG['ships'][type]['length'] * CONFIG['ships'][type]['width']
  end
end

class Board
  attr_accessor :board, :markers, :ships
  attr_reader :ships_composition

  def initialize(*sides)
    @board = ''
    @rows = sides[0]
    @cols = sides[1] ? sides[1] : sides[0]
    @ships_composition = CONFIG['ships_composition'].dup

    self.ships = []
    self.markers = Array.new(@rows) { Array.new(@cols) }
    build_board(@rows, @cols)
  end

  def mark!(row, col, marker)
    place(row - 1, col - 1, marker) if valid_row_col?(row, col)
  end

  def update!
    @board = ''
    build_board(@rows, @cols)
  end

  def random_add_ship
  end

  def random_add_all_ships
  end

  def add_ship(type, *coordinates)
    if CONFIG['ships'].keys.include?(type)                  &&
       valid_row_col?(coordinates[0][0], coordinates[0][1]) &&
       valid_row_col?(coordinates[1][0], coordinates[1][1]) &&
       valid_coordinates?(type, coordinates)                &&
       ship_with_board_allotment?(type)

      ships_composition.delete_at(ships_composition.index(type))
      return (ships << build_ship(type, coordinates))
    end
  end

  def display_board
    puts "#{board}"
  end

  def to_s
    "#{board}"
  end

  private

  def build_ship(type, coordinates)
    new_ship = Ship.new(type)
    new_ship.coordinates = coordinates
    new_ship
  end

  def ship_with_board_allotment?(type)
    ships_composition.include? type
  end

  def valid_coordinates?(type, coordinates)
    ship_top_left = [1, 1]
    ship_bottom_right = [CONFIG['ships'][type]['length'],
                         CONFIG['ships'][type]['width']]
    board_top_left = coordinates[0]
    board_bottom_right = coordinates[1]

    (((board_bottom_right[0] - ship_bottom_right[0]) -
      (board_top_left[0]     - ship_top_left[0])).abs ==
     ((board_bottom_right[1] - ship_bottom_right[1]) -
      (board_top_left[1]     - ship_top_left[1])).abs)
  end

  def valid_row_col?(row, col)
    row <= @rows && col <= @cols && row > 0 && col > 0
  end

  def place(row, col, marker)
    markers[row][col] = marker if markers[row][col].nil?
  end

  def build_board(rows, cols)
    rows.times do |row|
      board << draw_top_row(cols) if row == 0
      board << draw_top_bottom_cell(cols)
      board << draw_middle_cell(row, cols)
    end

    board << draw_top_bottom_cell(cols).chomp
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
