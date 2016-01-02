module BoardConstants

  TYPICAL_LINES = {blank: ' ' * 11 + '|', border: '-----------+'}

  DISPLAY_TEMPLATE = { x: ['   \   /   |', '    \ /    |', '     /     |', '    / \    |', '   /   \   |', TYPICAL_LINES[:border]],
    xh: ['   \   /   |', '    \ /    |', '     /     |', '    / \    |', '~~~/~~~\~~~|', TYPICAL_LINES[:border]],
    o: ['   .---.   |', '  :     :  |', '  |     |  |', '  :     ;  |', '   `---\'   |', TYPICAL_LINES[:border]],
    b: [TYPICAL_LINES[:blank], TYPICAL_LINES[:blank], TYPICAL_LINES[:blank], TYPICAL_LINES[:blank], TYPICAL_LINES[:blank], TYPICAL_LINES[:border]],
    bh1: ['          ==', '           |', '     _____/_', '    |       ', ' ~~~~~~~~~~~', TYPICAL_LINES[:border]],
    bh2: ['___\__     |', '______\_____', '______/_____', '> > >       ', '~~~~~~~~~~~~', TYPICAL_LINES[:border]],
    bh3: ['           |', '===        |', '\_______   |', '       /   |', '~~~~~~~~~~ |', TYPICAL_LINES[:border]],
    bv1: ['    /\     |', '   /  \    |', '  /    \   |', ' |      |  |', ' | _||_ |  |', '-||____||--+'],
    bv2: [' ||    ||  |', ' ||    ||  |', ' ||____||  |', ' ||____||  |', ' ||    ||  |', '-||____||--+'],
    bv3: [' | |  | |  |', ' | |  | |  |', '  \    /   |', '   \  /    |', '    \/     |', TYPICAL_LINES[:border]],
    bh1x: ['   \   /  ==', '    \ /    |', '     /____/_', '    / \     ', ' ~~/~~~\~~~~', TYPICAL_LINES[:border]],
    bh2x: ['___\__ /   |', '____\_/_____', '_____/______', '> > / \     ', '~~~/~~~\~~~~', TYPICAL_LINES[:border]],
    bh3x: ['   \   /   |', '=== \ /    |', '\____/__   |', '    / \/   |', '~~~/~~~\~~ |', TYPICAL_LINES[:border]],
    bv1x: ['   \/\ /   |', '   /\ /    |', '  /  / \   |', ' |  / \ |  |', ' | /||_\|  |', '-||____||--+'],
    bv2x: [' ||\   /|  |', ' || \ /||  |', ' ||__/_||  |', ' ||_/_\||  |', ' ||/   \|  |', '-||____||--+'],
    bv3x: [' | \  |/|  |', ' | |\ / |  |', '  \  / /   |', '   \/ \    |', '   /\/ \   |', TYPICAL_LINES[:border]],
    ch1: ['        __ |', '        \ \_', '      .--""_', '  .__.|-""".', ' ~\_________', TYPICAL_LINES[:border]],
    ch2: ['           |', '__==   ._  |', '__\..--"/  |', '.... \' /   |', '______/~~~ |', TYPICAL_LINES[:border]],
    cv1: ['    /\     |', '   /  \    |', '  /    \   |', ' | ____ |  |', ' ||    ||  |', ' ||____||--+'],
    cv2: [' ||____||  |', ' |  ||  |  |', '  \ || /   |', '   \  /    |', '    \/     |', '-----------+'],
    ch1x: ['   \   /__ |', '    \ / \ \_', '     /.--""_', '  ._/.\-""".', ' ~\/___\____', TYPICAL_LINES[:border]],
    ch2x: ['   \   /   |', '__==\ /._  |', '__\..\-"/  |', '..../\'\/   |', '___/__/\~~ |', TYPICAL_LINES[:border]],
    cv1x: ['   \/\ /   |', '   /\ /    |', '  /  / \   |', ' | _/_\ |  |', ' ||/   \|  |', ' ||____||--+'],
    cv2x: [' ||\___/|  |', ' |  \|/ |  |', '  \ |/ /   |', '   \/ \    |', '   /\/ \   |', TYPICAL_LINES[:border]],
    dh1: ['     _     |', '    /|\    |', '   /_|_\   |', ' ____|____ |', '~\_o_o_o_/~|',  TYPICAL_LINES[:border]],
    dh1x: ['   \ _ /   |', '    \|/    |', '   /_/_\   |', ' ___/|\___ |', '~\_/_o_\_/~|', TYPICAL_LINES[:border]]}

  GRID = [1, 2, 3, 4, 5]
  BOARD_COORDINATES = GRID.product(GRID)
  TOP_GRIDLINES = "         1           2           3           4           5      "
  BOARD_SPACING = " " * 20
  FIRST_LINE = "   +" + TYPICAL_LINES[:border] * 5
end

module Introable
  INTRO_TEMPLATE = {d1: ['         _         ', '        /|\        ', '       /_|_\       ', '     ____|____     ', '~ ~ ~\_o_o_o_/~ ~ ~'],
    d2: ['         _         ', '        /|\        ', '       /_|_\       ', '     ____|____     ', ' ~ ~ \_o_o_o_/ ~ ~ '],
    ds: ['    _ ', '   /|\ ', '  /_|_\ ', '____|____', '\_o_o_o_/', ''],
    b1: ['          ==___\__               ', '           |______\_____===      ', '     _____/_______/_____\________', '    |       > > >               /', '~~ ~~ ~~ ~~ ~~ ~~ ~ ~ ~ ~ ~ ~ ~ ~'],
    b2: ['          ==___\__               ', '           |______\_____===      ', '     _____/_______/_____\________', '    |       > > >               /', ' ~~~ ~~ ~~ ~~ ~~ ~ ~ ~ ~ ~ ~ ~ ~ ']}

  def intro_sequence
    system 'clear' or system 'cls'
    intro_first_line
    sleep 1
    little_ship_appear
    battleship_appear
    collision
    display_title
  end

  def intro_first_line
    print "\n\n" + " " * 55 + "SUPER EXCITING GAMES ON THE COMMAND LINE\n\n"
  end

  def intro_small
    intro_first_line
    print " " * 70 + "presents\n\n\n"
  end

  def little_ship_appear
    for j in 0..20
      ship_length = j < 19 ? j : 19
      for i in 0..4
        intro_lines[i] << " " * (151 - j) + INTRO_TEMPLATE["d#{j % 2 + 1}".to_sym][i].slice(0..ship_length) + "\n"
      end
      system 'clear' or system 'cls'
      intro_first_line
      print " " * 70 + "presents".slice(0..j)
      print "\n\n\n\n\n\n\n\n\n\n"
      intro_lines.each { |line| print line }
      self.intro_lines = ["","","","",""]
      sleep 1/5.0
    end
  end

  def battleship_appear
    for j in 0..104
      dship_distance = (j / 4)
      bship_distance = j < 33 ? 0 : j - 33
      ship_length = j < 33 ? j : 33
      for i in 0..4
        intro_lines[i] << " " * bship_distance + INTRO_TEMPLATE["b#{j % 2 + 1}".to_sym][i].slice((33 - ship_length)..33) +
          " " * (130 - j - dship_distance) + INTRO_TEMPLATE["d#{(j / 4 + 1) % 2 + 1}".to_sym][i] + "\n"
      end
      last_letter = j < 25 ? j : 25
      word_shift = (150 - j * 2) > 69 ? (150 - j * 2) : 69
      battleship_appearing = " " * word_shift + "BATTLESHIP".slice(0..last_letter) + "\n\n\n\n\n\n\n"
      system 'clear' or system 'cls'
      intro_small
      print battleship_appearing
      intro_lines.each { |line| print line }
      self.intro_lines = ["","","","",""]
      sleep 1/20.0
    end
  end

  def collision
    for j in 0..80
      ship_distance = 71 + j
      ship_exit = j < 47 ? 33 : 151 - ship_distance
      ship_gap = j < 4 ? [5, 4, 2, 1][j] : 0
      for i in 0..4
        if j < 4
          sinking = i
        else
          sinking = i - j + 4 >= 0 ? i - j + 4 : 5
        end
        intro_lines[i] << " " * ship_distance + INTRO_TEMPLATE["b#{j % 2 + 1}".to_sym][i].slice(0..ship_exit) +
          " " * ship_gap + INTRO_TEMPLATE[:ds][sinking] + (j < 9 && i == 4 ? "~ ~ ~" : "") + "\n"
      end
      word_shift = j < 14 ? (70 - j * 4) : 0
      battleship_line = " " * 69 + "BATTLESHIP" + " " * word_shift + "!" + "\n\n\n\n\n\n\n"
      system 'clear' or system 'cls'
      intro_small
      print battleship_line
      intro_lines.each { |line| print line }
      self.intro_lines = ["","","","",""]
      sleep 1/20.0
    end
  end

  def display_title
    system 'clear' or system 'cls'
    intro_small
    print " " * 69 + "BATTLESHIP!" + "\n\n\n"
  end
end

module Shippable
  TOTAL_GRIDS = 5
  SHIPS = ["battleship", "cruiser", "destroyer"]

  attr_accessor :human_ships, :computer_ships

  def initialize
    @human_ships = []
    @computer_ships = []
  end

  def place_ships(human_or_comp)
    human_or_comp == :human && manual_or_auto == "m" ? get_all_ships_manual : get_all_ships_auto(human_or_comp)
  end

  def manual_or_auto
    print "\n" + " " * 10 + "Manual or automatic board setup? (M/A): "
    input = gets.chomp.downcase
    puts
    return input if ["m", "a"].include?(input)
    loop do
      print "\n" + " " * 10 + "Please re-enter a valid option (\"m\" or \"a\"): "
      input = gets.chomp.downcase
      return input if ["m", "a"].include?(input)
    end
  end

  def get_all_ships_manual
    SHIPS.each do |current_ship|
      loop do
        ship_array = get_ship_array(*manual_input(current_ship))
        if check_valid_ship_coordinates(ship_array, human_board)
          add_ship_to_board(ship_array, :human)
          human_ships << ship_array
          break
        else
          print "The ship cannot be placed at this location. Please select a new location.\n\n"
          sleep 3
        end
      end
    end
  end

  def check_valid_ship_coordinates(ship_array, current_board)
    ship_array && ship_array.all? do |ship_square|
      current_board.select { |coord, val| val == :b }.keys.include?(ship_square[0])
    end
  end

  def manual_input(current_ship)
    refresh_display
    orientation = get_orientation(current_ship)
    symbol, ship_size = find_ship_info(current_ship, orientation)
    starting_coordinate = get_starting_coordinate(current_ship, orientation)
    [orientation, symbol, ship_size, starting_coordinate, :human]
  end

  def get_orientation(ship_type)
    return "h" if ship_type == "destroyer"
    print "Place #{ship_type} vertical or horizontal? (V/H): "
    input = gets.chomp.downcase
    puts
    return input if ["v", "h"].include?(input)
    loop do
      print "\nPlease re-enter a valid orientation (\"v\" or \"h\"): "
      input = gets.chomp.downcase
      puts
      return input if ["v", "h"].include?(input)
    end
  end

  def find_ship_info(name, orientation)
    case name
    when "battleship" then [:b, 3]
    when "cruiser" then [:c, 2]
    when "destroyer" then [:d, 1]
    end
  end

  def get_starting_coordinate(ship, orientation)
    print appropriate_coordinate_prompt(ship, orientation)
    input = gets.chomp.scan(/[1-5]/).map { |num| num.to_i }
    puts
    return input if input.size == 2
    loop do
      print "\nPlease re-enter valid coordinates: "
      input = gets.chomp.scan(/[1-5]/).map { |num| num.to_i }
      puts
      return input if input.size == 2
    end
  end

  def appropriate_coordinate_prompt(ship, orientation)
    if ship == "destroyer"
      "Select x, y coordinates for the #{ship}. (X, Y): "
    elsif orientation == "h"
      "Select x, y coordinates for the left end of the #{ship}. (X, Y): "
    else
      "Select x, y coordinates for the top of the #{ship}. (X, Y): "
    end
  end

  def get_all_ships_auto(human_or_comp)
    current_board = human_or_comp == :human ? human_board : computer_board
    SHIPS.each do |current_ship|
      loop do
        ship_array = get_ship_array(*auto_input(current_ship, human_or_comp))
        if check_valid_ship_coordinates(ship_array, current_board)
          add_ship_to_board(ship_array, human_or_comp)
          human_or_comp == :human ? human_ships << ship_array : computer_ships << ship_array
          break
        end
      end
    end
  end

  def auto_input(current_ship, human_or_comp)
    current_board = human_or_comp == :human ? human_board : computer_board
    orientation = ["h", "v"].sample
    symbol, ship_size = find_ship_info(current_ship, orientation)
    starting_coordinate = auto_starting_coordinate(current_board, ship_size, orientation)
    [orientation, symbol, ship_size, starting_coordinate, human_or_comp]
  end

  def auto_starting_coordinate(current_board, ship_size, orientation)
    current_board.select do |coord, val|
      val == :b &&
        (coord[0] <= TOTAL_GRIDS - ship_size + 1 && orientation == "h" ||
        coord[1] <= TOTAL_GRIDS - ship_size + 1 && orientation == "v")
    end.keys.sample
  end

  def add_ship_to_board(ship_array, human_or_comp)
    for i in 0..(ship_array.size - 1)
      if human_or_comp == :human
        human_board[ship_array[i][0]] = ship_array[i][1]
      else
        computer_board[ship_array[i][0]] = ship_array[i][1]
      end
    end
  end

  def get_ship_array(orientation, symbol, ship_size, first_coord, human_or_comp)
    orientation = "h" if symbol == :d
    ship_array = populate_ship_array(orientation, symbol, ship_size, first_coord, human_or_comp)
    return false if overlapping_ships?(ship_array, human_or_comp)
    ship_array
  end

  def populate_ship_array(orientation, symbol, ship_size, first_coord, human_or_comp)
    ship_array = []
    for i in 1..ship_size
      ship_label = "#{symbol}#{orientation}#{i}".to_sym
      x_coord = orientation == "h" ? first_coord[0] + i - 1 : first_coord[0]
      y_coord = orientation == "v" ? first_coord[1] + i - 1 : first_coord[1]
      ship_coord = [x_coord, y_coord]
      ship_array << [ship_coord, ship_label]
    end
    ship_array
  end

  def overlapping_ships?(ship_array, human_or_comp)
    if human_or_comp == :human
      ship_array.flatten.any? { |coord| human_ships.map { |ship| ship[0] }.include?(coord) }
    else
      ship_array.flatten.any? { |coord| computer_ships.map { |ship| ship[0] }.include?(coord) }
    end
  end
end


class Table
  include BoardConstants
  include Shippable

  attr_accessor :human_board, :computer_board, :human_name, :flash_board, :flash_regex, :flash_on, :flash_player

  def initialize(name)
    @human_board = initialize_board
    @computer_board = initialize_board
    @human_name = name
    @flash_board = nil
    @flash_regex = nil
    @flash_on = false
    @flash_player = nil
    super()
  end

  def initialize_board
    blank_board = {}
    BOARD_COORDINATES.each { |coord| blank_board[coord] = :b }
    blank_board
  end

  def refresh_display
    system 'clear' or system 'cls'
    print_board
  end

  def print_board
    print_top_of_board
    printing_array = []
    board1, board2 = flash_on ? set_flash_board : [human_board, computer_board]
    for i in 1..5
      printing_array << board1.values_at(*GRID.product([i])) +
        hide_ships(board2.values_at(*GRID.product([i])))
    end
    printing_array.each_with_index do |row_array, row_index|
      print_row(row_array, row_index)
    end
    print_ship_statuses
  end

  def print_top_of_board
    puts
    puts "-" * 70 + "BATTLESHIP!" + "-" * 70 + "\n\n"
    puts "   " + " " * (30 - "#{human_name.upcase}'S BOARD".length / 2) + "#{human_name.upcase}'S BOARD" + " " *
      (31 - "#{human_name.upcase}'S BOARD".length / 2) + BOARD_SPACING + " " * 25 + "COMPUTER'S BOARD" + "\n\n"
    puts TOP_GRIDLINES + BOARD_SPACING + TOP_GRIDLINES
    puts FIRST_LINE + BOARD_SPACING + FIRST_LINE
  end

  def set_flash_board
    if flash_player == :human_board
      return flash_board, computer_board
    else
      return human_board, flash_board
    end
  end

  def print_ship_statuses
    print "\n   #{human_name.upcase}'S FLEET STATUS:" + " " * (68 - human_name.length) + "COMPUTER'S FLEET STATUS\n\n   "
    [:human_board, :computer_board].each do |board|
      SHIPS.each do |ship|
        print "#{ship.capitalize}: #{ship_status(ship, board)}    "
      end
      print " " * 25
    end
    print "\n\n" + "-" * 151 + "\n\n"
  end

  def ship_status(ship, which_board)
    current_board = which_board == :human_board ? human_board : computer_board
    status = current_board.values.any? { |val| /#{ship.chars.first}./.match(val) && !/x/.match(val) }
    status ? "Alive" : "Sunk "
  end

  def hide_ships(values)
    values.map do |val|
      if [:b, :o].include?(val)
        val
      else
        /x/.match(val) ? :x : :b
      end
    end
  end

  def print_row(row_array, row_index)
    for i in 0..5
      print i == 2 ? " #{row_index + 1} " : "   "
      print i == 5 ? "+" : "|"
      print_row_squares(row_array, row_index, i)
      print "\n"
    end
  end

  def print_row_squares(row_array, row_index, i)
    row_array.each_with_index do |square_value, square_index|
      if square_index == 5
        print BOARD_SPACING
        print i == 2 ? " #{row_index + 1} " : "   "
        print i == 5 ? "+" : "|"
      end
      print DISPLAY_TEMPLATE[square_value][i]
    end
  end

  def update_board(coord, which_board)
    current_board = which_board == :human_board ? human_board : computer_board
    update_value_at_coord(coord, current_board)
    refresh_display
    set_flash(coord, current_board, which_board)
    if flash_board
      update_values_for_flashing(current_board, which_board)
      flash_sinking_ship
    end
    self.flash_board = nil
  end

  def update_value_at_coord(coord, current_board)
    if current_board[coord] == :b
      current_board[coord] = :o
    else
      current_board[coord] = "#{current_board[coord]}x".to_sym
    end
  end

  def set_flash(coord, current_board, which_board)
    current_val = current_board[coord]
    ["b.", "c", "d"].each do |regex|
      if /#{regex}/.match(current_val)
        if current_board.values.select { |val| /#{regex}/.match(val) }.all? { |val| /x/.match(val) }
          self.flash_board = current_board.dup
          self.flash_regex = regex
          self.flash_player = which_board
        end
      end
    end
  end

  def update_values_for_flashing(current_board, which_board)
    if which_board == :human_board
      update_sunk_ship_values(current_board)
    else
      update_flash_board_with_blanks
    end
  end

  def update_sunk_ship_values(current_board)
    current_board.each do |coord, val|
      if /#{flash_regex}/.match(val)
        current_board[coord] = /h/.match(val) ? :xh : :x
      end
    end
  end

  def update_flash_board_with_blanks
    flash_board.each do |coord, val|
      if /#{flash_regex}/.match(val)
        flash_board[coord] = :b
      end
    end
  end

  def flash_sinking_ship
    4.times do
      sleep 1/5.0
      self.flash_on = true
      refresh_display
      sleep 1/5.0
      self.flash_on = false
      refresh_display
    end
  end

  def check_winner(which_board)
    current_board = which_board == :human_board ? human_board : computer_board
    if current_board.values.all? {|val| /x/.match(val) || [:o, :b].include?(val) }
      which_board == :human_board ? :computer : :human
    end
  end
end

class Human
  attr_reader :name

  def initialize
    @name = get_name
  end

  def get_name
    print " " * 10 + "Please enter your name: "
    input_name = gets.chomp.capitalize
    return input_name unless input_name.empty?
    loop do
      print "\n" + " " * 10 + "Please re-enter a valid name: "
      input_name = gets.chomp.capitalize
      return input_name unless input_name.empty?
    end
  end

  def select_location(computer_board)
    print "Select the coordinates of your next attack (x, y): "
    input = gets.chomp.scan(/[1-5]/).map { |num| num.to_i }
    puts
    return input if input.size == 2 && computer_board[input] &&
      !/x/.match(computer_board[input]) && computer_board[input] != :o
    loop do
      print "\nPlease re-enter valid coordinates: "
      input = gets.chomp.scan(/[1-5]/).map { |num| num.to_i }
      puts
      return input if input.size == 2 && computer_board[input] &&
        !/x/.match(computer_board[input]) && computer_board[input] != :o
    end
  end
end

class Computer
  def select_location(human_board)
    sleep 1/2.0
    human_board.select { |coord, val| !/x/.match(val) && val != :o }.keys.sample
  end
end

class Game
  include Introable

  attr_accessor :winner, :intro_lines
  attr_reader :table, :human, :computer

  def initialize
    @intro_lines = ["","","","",""]
    intro_sequence unless winner
    @human ||= Human.new
    @computer ||= Computer.new
    @table = Table.new(human.name)
    @winner = nil
  end

  def play
    loop do
      table.place_ships(:human)
      table.place_ships(:computer)
      table.refresh_display
      loop do
        table.update_board(human.select_location(table.computer_board), :computer_board)
        break if self.winner = table.check_winner(:computer_board)
        table.update_board(computer.select_location(table.human_board), :human_board)
        break if self.winner = table.check_winner(:human_board)
      end
      display_winner_message
      break if replay?
      initialize
    end
  end

  def replay?
    puts "Enter 'y' if you would like to play again"
    gets.chomp.downcase != 'y'
  end

  def display_winner_message
    sleep 1
    puts winner == :human ? "Congratulations! You won!\n\n" : "You have been defeated.\n\n"
    sleep 1
  end
end


Game.new.play
