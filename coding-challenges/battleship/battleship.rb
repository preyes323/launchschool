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
  attr_reader :name
  attr_accessor :board

  def initialize(name = '', size = 5)
    self.name = name
    self.board = Board.new(5)
  end

  def name=(name)
    @name = name.rstrip.empty? ? 'NO_NAME' : name
  end

  def random_position_all_ships
    board.random_add_all_ships
  end
end

class Human < Player
  def attack_coordinate!(opponent_board)
    loop do
      puts 'Choose a coordinate on the opponents board to attack:'
      move = gets.chopm.split(',').map(&:to_i)

      if opponent_board.available_moves.include? move
        marker = opponent_board.ship_hit?(move) ? 'x' : '/'
        opponent_board.mark!(move[0], move[1], marker)
        opponent_board.update!
        break
      end
    end
  end

  def add_ships
    CONFIG['num_ships'].times do
      loop do
        puts "#{board}"
        puts ''
        puts 'Available ships to add'
        puts '----------------------'
        board.ships_composition.each { |ship| puts ship }
        puts '----------------------'
        print '=> '
        ship_type = gets.chomp.downcase

        top_left = input_coordinates('top left')
        bottom_right = input_coordinates('bottom right')

        if board.add_ship(ship_type, top_left, bottom_right)
          board.display_last_added_ship
          break
        end
      end
    end
  end

  private

  def input_coordinates(location)
    loop do
      print "Enter #{location} coordinates: "
      coordinates = gets.chomp
      return coordinates.split(',').map(&:to_i) if coordinates =~ /\d+,\s*\d+/
    end
  end
end

class Computer < Player
  NAMES = ['Hal', 'R2D2', 'Deep blue', 'C3P0']

  def initialize
    super
    self.name = NAMES.sample
  end

  def attack_coordinate!(opponent_board)
    move = opponent_board.available_moves.sample
    marker = opponent_board.ship_hit?(move) ? 'x' : '/'
    opponent_board.mark!(move[0], move[1], marker)
    opponent_board.update!
  end
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

  def sunk?
    hitpoints == 0
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

    initialize_board_and_ships
    build_board(@rows, @cols)
  end

  def available_moves
    retrieve_coordinates_for(nil)
  end

  def ship_hit?(coordinates)
    ships.each do |ship|
      ship_coords = enumerate_coordinates(ship.coordinates[0],
                                          ship.coordinates[1])
      if ship_coords.include?(coordinates)
        ship.hitpoints -= 1
        return true
      end
    end
    false
  end

  def all_ships_sunk?
    ships.all? { |ship| ship.sunk? }
  end

  def mark!(row, col, marker)
    place(row - 1, col - 1, marker) if valid_row_col?(row, col)
  end

  def update!
    @board = ''
    build_board(@rows, @cols)
  end

  def random_add_ship(type)
    available_coordinates = retrieve_coordinates_for(nil)
    available_coordinates.shuffle!

    available_coordinates.each do |coordinate|
      if lengthwise?(type, coordinate) || widthwise?(type, coordinate)
        return 'added'
      end
    end

    false
  end

  def random_add_all_ships
    attempts = 0
    loop do
      attempts += 1
      initialize_board_and_ships

      CONFIG['num_ships'].times do |ship_num|
        ship_added = if CONFIG['ships_composition'].first == 'any'
                       random_add_ship(CONFIG['ships'].keys.sample)
                     else
                       random_add_ship(ships_composition.sample)
                     end

        ship_added ? mark_last_added_ship : break
      end

      if ships.length == CONFIG['num_ships']
        initialize_board
        return "#{attempts}"
      end

      if attempts >= CONFIG['max_random_tries']
        puts "Ships seem impossible to add. Please check they fit the board"
        break
      end

    end
  end

  def add_ship(type, *coordinates)
    if CONFIG['ships'].keys.include?(type)                  &&
       valid_row_col?(coordinates[0][0], coordinates[0][1]) &&
       valid_row_col?(coordinates[1][0], coordinates[1][1]) &&
       valid_coordinates?(type, coordinates)                &&
       space_empty?(coordinates)                            &&
       ship_with_board_allotment?(type)

      return (ships << build_ship(type, coordinates))
    end
  end

  def display_last_added_ship
    mark_last_added_ship
    update!
    to_s
  end

  def display_board
    puts "#{board}"
  end

  def to_s
    "#{board}"
  end

  private

  def mark_last_added_ship
    ship_coords = enumerate_coordinates(ships.last.coordinates[0],
                                              ships.last.coordinates[1])
    mark_coords(ship_coords)
  end

  def initialize_board_and_ships
    initialize_board
    @ships_composition = CONFIG['ships_composition'].dup
    self.ships = []
  end

  def initialize_board
    self.markers = Array.new(@rows) { Array.new(@cols) }
  end

  def retrieve_coordinates_for(marker)
    coords = markers.map.with_index do |row, row_indx|
               row.map.with_index do |col, col_indx|
                 if markers[row_indx][col_indx] == marker
                   [row_indx + 1, col_indx + 1]
                 end
               end
             end.flatten(1)

    coords.delete(nil)
    coords
  end

  def space_empty?(coordinates)
    return 'empty' if ships.empty?

    new_ship_coords = enumerate_coordinates(coordinates[0], coordinates[1])

    new_ship_coords.each do |coord|
      ships.each do |ship|
        top_left = ship.coordinates[0]
        bottom_right = ship.coordinates[1]

        if coord_inside?(coord, top_left, bottom_right)
          return false
        end

      end
    end

    'empty'
  end

  def enumerate_coordinates(top_left, bottom_right)
    coordinates = []
    top_left[0].upto(bottom_right[0]) do |row|
      top_left[1].upto(bottom_right[1]) do |col|
        coordinates << [row, col]
      end
    end
    coordinates
  end

  def coord_inside?(test_coord, existing_top_left, existing_bottom_right)
    test_coord[0] >= existing_top_left[0]     &&
    test_coord[1] >= existing_top_left[1]     &&
    test_coord[0] <= existing_bottom_right[0] &&
    test_coord[1] <= existing_bottom_right[1]
  end

  def lengthwise?(type, coordinate)
    length = CONFIG['ships'][type]['length'] - 1
    width = CONFIG['ships'][type]['width'] - 1
    add_ship(type, coordinate, [coordinate[0] + length,
                                coordinate[1] + width])
  end

  def widthwise?(type, coordinate)
    length = CONFIG['ships'][type]['length'] - 1
    width = CONFIG['ships'][type]['width'] - 1
    add_ship(type, coordinate, [coordinate[0] + width,
                                coordinate[1] + length])
  end

  def build_ship(type, coordinates)
    new_ship = Ship.new(type)
    new_ship.coordinates = coordinates
    new_ship
  end

  def ship_with_board_allotment?(type)
    return true if ships_composition.include? 'any'
    if ships_composition.include? type
      ships_composition.delete_at(ships_composition.index(type))
    end
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

  def mark_coords(coords)
    coords.each do |coord|
      place(coord[0] - 1, coord[1] - 1, 'x')
    end
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

class BattleshipGame
  attr_accessor :human, :computer

  def initialize
    self.human = Human.new('Paolo')
    self.computer = Computer.new
  end

  def play
    system 'clear'
    human_player_add_ships

    human.board.display_board

    puts ''
    puts ''
    computer.board.display_board
    computer.random_position_all_ships
    binding.pry
  end

  private

  def human_player_add_ships
    choice = ''

    loop do
      puts "Randomly add all ships? (y/n)"
      choice = gets.chomp.downcase
      break if %w(y n).include? choice
    end

    choice == 'y' ? human.random_position_all_ships : human.add_ships
  end
end

BattleshipGame.new.play
