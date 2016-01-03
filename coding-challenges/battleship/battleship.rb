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
require 'io/console'


class Player
  attr_reader :name
  attr_accessor :board

  def initialize(name = '', size = 5)
    self.name = name
    self.board = Board.new(size)
  end

  def name=(name)
    @name = name.rstrip.empty? ? 'NO_NAME' : name
  end

  def random_position_all_ships
    board.random_add_all_ships
  end

  def lives
    result = 0
    board.ships.each { |ship| result += ship.hitpoints }
    result
  end
end

class Human < Player
  def attack_coordinate!(opponent_board)
    loop do
      puts '(valid coordinate input: 1,2 or 1, 2)'
      move = input_coordinates('the')
      if opponent_board.available_moves.include? move
        marker = opponent_board.ship_hit?(move) ? 'x' : '/'
        opponent_board.mark!(move[0], move[1], marker)
        opponent_board.update!
        return move
      else
        puts 'Not a valid coordinate, please try again.'
        sleep 1
      end
    end
  end

  def add_ships
    BattleshipGame.config['num_ships'].times do
      loop do
        system 'clear' or system 'cls'
        puts "#{board}"
        puts ''
        puts 'Available ships to add'
        puts '----------------------'
        board.ships_composition.each do |ship|
          print "#{ship} (dimension: "
          print "#{BattleshipGame.config['ships'][ship]['length']} x "
          puts "#{BattleshipGame.config['ships'][ship]['width']})"
        end
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

  def initialize(size = 5)
    name = NAMES.sample
    super(name, size)
  end

  def attack_coordinate!(opponent_board)
    move = opponent_board.available_moves.sample
    marker = opponent_board.ship_hit?(move) ? 'x' : '/'
    opponent_board.mark!(move[0], move[1], marker)
    opponent_board.update!
    move
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
    BattleshipGame.config['ships'][type]['length'] * BattleshipGame.config['ships'][type]['width']
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

  def initialize_board_and_ships
    initialize_board
    @ships_composition = BattleshipGame.config['ships_composition'].dup
    self.ships = []
  end

  def initialize_board
    self.markers = Array.new(@rows) { Array.new(@cols) }
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

      BattleshipGame.config['num_ships'].times do |ship_num|
        ship_added = if BattleshipGame.config['ships_composition'].first == 'any'
                       random_add_ship(BattleshipGame.config['ships'].keys.sample)
                     else
                       random_add_ship(ships_composition.sample)
                     end

        ship_added ? mark_last_added_ship : break
      end

      if ships.length == BattleshipGame.config['num_ships']
        initialize_board
        return "#{attempts}"
      end

      if attempts >= BattleshipGame.config['max_random_tries']
        puts "Ships seem impossible to add. Please check they fit the board"
        break
      end

    end
  end

  def add_ship(type, *coordinates)
    if BattleshipGame.config['ships'].keys.include?(type)                  &&
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
    length = BattleshipGame.config['ships'][type]['length'] - 1
    width = BattleshipGame.config['ships'][type]['width'] - 1
    add_ship(type, coordinate, [coordinate[0] + length,
                                coordinate[1] + width])
  end

  def widthwise?(type, coordinate)
    length = BattleshipGame.config['ships'][type]['length'] - 1
    width = BattleshipGame.config['ships'][type]['width'] - 1
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
    ship_bottom_right = [BattleshipGame.config['ships'][type]['length'],
                         BattleshipGame.config['ships'][type]['width']]
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
    case markers[row][col]
    when 'x'
      "#{markers[row][col].to_s.center(3, ' ')}".colorize(:red)
    when '/'
      "#{markers[row][col].to_s.center(3, ' ')}".colorize(:light_blue)
    else
      "#{markers[row][col].to_s.center(3, ' ')}"
    end
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
  @@config = YAML.load_file('ts_battleship_config.yml')

  attr_accessor :human, :computer, :current_player

  def self.update_config(filename)
    @@config = YAML.load_file(filename)
  end

  def self.config
    @@config
  end

  def initialize
    welcome_routine

    system 'clear' or system 'cls'
    puts 'What is your name commander? '
    player_name = gets.chomp

    battlefield = decide_battlefield
    self.human = Human.new(player_name, battlefield)
    self.computer = Computer.new(battlefield)
  end

  def play
    system 'clear' or system 'cls'
    human_player_add_ships
    computer.random_position_all_ships
    self.current_player = assign_random_player

    loop do
      display_boards

      puts ''
      puts "#{current_player.name}'s turn to attack"
      p current_player.attack_coordinate!(next_player.board)
      delay_screen_update if current_player == computer


      break if next_player.board.all_ships_sunk?
      self.current_player = next_player
    end

    display_boards
    puts "#{current_player.name} won!"
    sleep 5
  end

  private

  def welcome_routine
    system 'clear' or system 'cls'
    puts BattleshipGame.config['welcome_message']
    puts ''
    puts 'Press enter to continue'
    gets.chomp
  end

  def decide_battlefield
    loop do
      rows, _ = $stdin.winsize
      puts 'Choose your battlefield'
      puts '-----------------------'
      puts '[s]kirmish'
      puts '[b]attle zone'
      puts '[w]ar zone'
      puts '[c]ustom'
      puts '-----------------------'
      print '=> '

      ans = gets.chomp
      ans = load_battlefield(ans, rows)
      sleep 5 unless ans

      return BattleshipGame.config['dimension'] if ans
    end
  end

  def load_battlefield(ans, rows)
    load_resp = case ans
                when 's'
                  if rows >= 34
                    BattleshipGame.update_config('battleship_config.yml')
                  end
                when 'b'
                  if rows >= 48
                    BattleshipGame.update_config('battlezone_config.yml')
                  end
                when 'w'
                  if rows >= 57
                    BattleshipGame.update_config('warzone_config.yml')
                  end
                when 'c' then load_custom_battlefield(rows)
                end

    return load_resp if load_resp

    puts BattleshipGame.config['landscape_error']
  end

  def load_custom_battlefield(rows)
    system 'clear' or system 'cls'
    puts "Warning this will load the custom file 'custom_config.yml'"
    puts 'If file is not found, it will default to skirmish mode'
    sleep 3

    begin
      BattleshipGame.update_config('custom_config.yml')
    rescue
      system 'clear' or system 'cls'
      puts 'Trying to default to skirmish mode..'
      sleep 3
      if rows >= 34
        BattleshipGame.update_config('battleship_config.yml')
      else
        puts '... Failed to load.'
        puts ''
      end
    end
  end

  def display_boards
    system 'clear' or system 'cls'
    puts "#{human.name}'s board".colorize(:light_blue)
    puts "Hitpoints: #{human.lives}".colorize(:green)
    puts '---'
    human.board.display_board

    puts ''
    puts "#{computer.name}'s board".colorize(:light_blue)
    puts "Hitpoints: #{computer.lives}".colorize(:green)
    puts '---'
    computer.board.display_board
  end

  def assign_random_player
    %w(h c).sample == 'h' ? human : computer
  end

  def next_player
    current_player.class == Human ? computer : human
  end

  def delay_screen_update
    sleep 3
  end

  def human_player_add_ships
    choice = ''

    loop do
      puts "Let the strategist position the ships? (y/n)"
      choice = gets.chomp.downcase
      break if %w(y n).include? choice
    end

    choice == 'y' ? human.random_position_all_ships : human.add_ships
    human.board.initialize_board
    human.board.update!
  end
end

BattleshipGame.new.play
