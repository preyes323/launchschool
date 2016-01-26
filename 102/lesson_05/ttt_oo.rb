require 'yaml'
require 'pry'

CONFIG = YAML.load_file('ttt_config.yml')

class Marker
  attr_reader :mark, :owner

  def initialize(mark, owner)
    if mark.length > CONFIG['allowed_marker_length']
      raise ArgumentError, 'Mark exceeds allowed length'
    end

    @mark = mark
    @owner = owner
  end

  def to_s
    "#{owner}: #{mark}"
  end

  def ==(other)
    mark == other.mark
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
    if mark_exists?(marker) || owner_exists?(marker)
      raise ArgumentError, 'Mark and owner must be unique'
    end

    collection.push marker
  end

  def []=(idx, obj)
    raise ArgumentError, 'Mark is in use' if mark_exists?(obj)
    collection[idx] = obj
  end

  def [](idx)
    collection[idx]
  end

  def marker_of(owner)
    collection.select { |marker| marker.owner.equal? owner }[0]
  end

  def owners
    collection.map(&:owner)
  end

  def marks
    collection.map(&:mark)
  end

  def mark_exists?(marker)
    marks.include? marker.mark
  end

  def owner_exists?(marker)
    owners.include? marker.owner
  end

  def other_than(other_mark)
    marks.keep_if { |mark| mark != other_mark }
  end

  def to_s
    collection.map do |marker|
      [marker.owner, marker.mark]
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

  def winner?(mark, board)
    winning_score = board.neighborhood_depth * 2 + 1
    Vertical.score_for(mark, location, board)     == winning_score ||
      Horizontal.score_for(mark, location, board) == winning_score ||
      RightDiag.score_for(mark, location, board)  == winning_score ||
      LeftDiag.score_for(mark, location, board)   == winning_score
  end

  def score_for(mark, board)
    Vertical.score_for(mark, location, board)     +
      Horizontal.score_for(mark, location, board) +
      RightDiag.score_for(mark, location, board)  +
      LeftDiag.score_for(mark, location, board)
  end

  def win_on_next_square(mark, board)
    winning_score = board.neighborhood_depth * 2
    case winning_score
    when Vertical.score_for(mark, location, board)
      Vertical.empty_neighbors_for(location, board)[0]
    when Horizontal.score_for(mark, location, board)
      Horizontal.empty_neighbors_for(location, board)[0]
    when RightDiag.score_for(mark, location, board)
      RightDiag.empty_neighbors_for(location, board)[0]
    when LeftDiag.score_for(mark, location, board)
      LeftDiag.empty_neighbors_for(location, board)[0]
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
      (top_score(mark, location, board) +
       bottom_score(mark, location, board) +
       Neighborhood.current(mark, location, board))
    end

    def self.empty_neighbors_for(location, board)
      empty_top(location, board) + empty_bottom(location, board)
    end

    def self.empty_top(location, board)
      result = []
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] - (offset + 1), location[1]]
        break if new_location[0] < Neighborhood.top_left_limit[0]
        if board.square_at(new_location).mark == ''
          result << board.square_at(new_location)
        end
      end
      result
    end

    def self.empty_bottom(location, board)
      result = []
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] + (offset + 1), location[1]]
        break if new_location[0] > Neighborhood.bottom_right_limit[0]
        if board.square_at(new_location).mark == ''
          result << board.square_at(new_location)
        end
      end
      result
    end

    def self.top_score(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] - (offset + 1), location[1]]
        break if new_location[0] < Neighborhood.top_left_limit[0]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end

    def self.bottom_score(mark, location, board)
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
      (left_score(mark, location, board) +
       right_score(mark, location, board) +
       Neighborhood.current(mark, location, board))
    end

    def self.empty_neighbors_for(location, board)
      empty_left(location, board) + empty_right(location, board)
    end

    def self.empty_left(location, board)
      result = []
      board.neighborhood_depth.times do |offset|
        new_location = [location[0], location[1] - (offset + 1)]
        break if new_location[1] < Neighborhood.top_left_limit[1]
        if board.square_at(new_location).mark == ''
          result << board.square_at(new_location)
        end
      end
      result
    end

    def self.empty_right(location, board)
      result = []
      board.neighborhood_depth.times do |offset|
        new_location = [location[0], location[1] + (offset + 1)]
        break if new_location[1] > Neighborhood.bottom_right_limit[1]
        if board.square_at(new_location).mark == ''
          result << board.square_at(new_location)
        end
      end
      result
    end

    def self.left_score(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0], location[1] - (offset + 1)]
        break if new_location[1] < Neighborhood.top_left_limit[1]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end

    def self.right_score(mark, location, board)
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
      (upper_left_score(mark, location, board) +
       lower_right_score(mark, location, board) +
       Neighborhood.current(mark, location, board))
    end

    def self.empty_neighbors_for(location, board)
      empty_upper_left(location, board) + empty_lower_right(location, board)
    end

    def self.empty_upper_left(location, board)
      result = []
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] - (offset + 1),
                        location[1] - (offset + 1)]
        break if new_location[1] < Neighborhood.top_left_limit[1] ||
                 new_location[0] < Neighborhood.top_left_limit[0]
        if board.square_at(new_location).mark == ''
          result << board.square_at(new_location)
        end
      end
      result
    end

    def self.empty_lower_right(location, board)
      result = []
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] + (offset + 1),
                        location[1] + (offset + 1)]
        break if new_location[1] > Neighborhood.bottom_right_limit[1] ||
                 new_location[0] > Neighborhood.bottom_right_limit[0]
        if board.square_at(new_location).mark == ''
          result << board.square_at(new_location)
        end
      end
      result
    end

    def self.upper_left_score(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] - (offset + 1),
                        location[1] - (offset + 1)]
        break if new_location[1] < Neighborhood.top_left_limit[1] ||
                 new_location[0] < Neighborhood.top_left_limit[0]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end

    def self.lower_right_score(mark, location, board)
      score = 0
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] + (offset + 1),
                        location[1] + (offset + 1)]
        break if new_location[1] > Neighborhood.bottom_right_limit[1] ||
                 new_location[0] > Neighborhood.bottom_right_limit[0]
        score += 1 if board.square_at(new_location).mark == mark
      end
      score
    end
  end

  module LeftDiag
    def self.score_for(mark, location, board)
      return 0 unless board.square_at(location)
      (upper_right_score(mark, location, board) +
       lower_left_score(mark, location, board) +
       Neighborhood.current(mark, location, board))
    end

    def self.empty_neighbors_for(location, board)
      empty_upper_right(location, board) + empty_lower_left(location, board)
    end

    def self.empty_upper_right(location, board)
      result = []
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] - (offset + 1),
                        location[1] + (offset + 1)]
        break if new_location[1] > Neighborhood.bottom_right_limit[1] ||
                 new_location[0] < Neighborhood.top_left_limit[0]
        if board.square_at(new_location).mark == ''
          result << board.square_at(new_location)
        end
      end
      result
    end

    def self.empty_lower_left(location, board)
      result = []
      board.neighborhood_depth.times do |offset|
        new_location = [location[0] + (offset + 1),
                        location[1] - (offset + 1)]
        break if new_location[1] < Neighborhood.top_left_limit[1] ||
                 new_location[0] > Neighborhood.bottom_right_limit[0]
        if board.square_at(new_location).mark == ''
          result << board.square_at(new_location)
        end
      end
      result
    end

    def self.upper_right_score(mark, location, board)
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

    def self.lower_left_score(mark, location, board)
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
    build(CONFIG[game_type]['board_size'])
    self.neighborhood_depth = CONFIG[game_type]['neighborhood_depth']
  end

  def empty_squares_location
    empty_squares.map(&:location)
  end

  def full?
    empty_squares.empty?
  end

  def mark_wins?(mark)
    squares.any? { |square| square.winner?(mark, self) }
  end

  def empty_squares
    squares.select { |square| empty_square?(square.location) }
  end

  def empty_square?(location)
    square_at(location).mark == ''
  end

  def update_square_at(location, marker)
    square_at(location).mark = marker if square_at(location)
  end

  def square_at(location)
    squares.select { |square| square.location == location }[0]
  end

  def draw
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

  def build(size)
    self.squares = []
    size.times do |row|
      size.times { |col| squares << Square.new('', [row, col]) }
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
    update_top_left_bottom_right(@location)
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
  def move(board)
    puts 'Input a location in the board to put marker (i.e. 1, 1).'
    loop do
      print '=> '
      move = gets.chomp
      location = move.split(',')
      if valid_move?(location) && valid_location?(location.map(&:to_i), board)
        return location.map(&:to_i)
      end
    end
  end

  def choose_marker(markers)
    puts "What marker do you want to use for the game #{name}?"

    begin
      print '=> '
      mark = gets.chomp
      markers << Marker.new(mark, self)
    rescue ArgumentError
      retry
    end
  end

  def valid_move?(move)
    move.length == 2 && move.all? { |input| input =~ /\d/ }
  end

  def valid_location?(location, board)
    board.empty_square?(location)
  end
end

class Computer < Player
  def initialize
    name = CONFIG['computer_names'].sample
    super(name)
  end

  def choose_marker(markers)
    begin
      mark = CONFIG['computer_marker_choices'].sample
      markers << Marker.new(mark, self)
    rescue ArgumentError
      retry
    end
  end

  def move(board, markers)
    result = if !opponents_winning_move(board, markers).empty?
               opponents_winning_move(board, markers)
             elsif !winning_move(board, markers).empty?
               winning_move(board, markers)
             else
               high_value_squares(board, markers)
             end

    result.sample
  end

  def get_mark(markers)
    markers.marker_of(self).mark
  end

  def winning_move(board, markers)
    squares = []
    board.squares.select do |square|
      squares << square.win_on_next_square(get_mark(markers), board)
    end
    squares.compact
  end

  def opponents_winning_move(board, markers)
    squares = []
    other_markers = markers.other_than(get_mark(markers))

    other_markers.each do |mark|
      board.squares.select do |square|
        squares << square.win_on_next_square(mark, board)
      end
    end

    squares.compact
  end

  def high_value_squares(board, markers)
    squares = {}
    possible_squares = board.empty_squares
    max_score = 0

    possible_squares.each do |square|
      score = square.score_for(get_mark(markers), board)
      squares[square] = score
      max_score = score > max_score ? score : max_score
    end

    squares.keep_if { |_, score| score == max_score }.keys
  end
end

class TTTGame
  attr_accessor :players, :markers, :scores, :current_marker
  attr_reader :board, :game_type

  def initialize
    @game_type = game_selection

    self.players = players_setup
    initialize_player_scores

    self.markers = Markers.new
    setup_players_marker(markers)
  end

  def play
    loop do
      winner = nil
      round = 0

      initialize_game

      loop do
        move = player_move(current_marker.owner)
        sleep 1 if current_marker.owner.class == Computer

        board.update_square_at(move, current_marker.mark)
        display_game_area
        winner = current_marker.owner if board.mark_wins?(current_marker.mark)

        break if board.full? || winner
        round += 1
        self.current_marker = next_marker(round)
      end

      process_results(winner)
      break unless play_again?
    end
  end

  private

  def initialize_game
    @board = Board.new(game_type)
    display_game_area
    self.current_marker = markers.first
  end

  def process_results(winner)
    scores[winner] += 1 if winner
    display_game_area
    display_results(winner)
  end

  def display_results(winner)
    puts '+----------=----------+'
    if winner
      puts "#{winner.name}(#{markers.marker_of(winner).mark}) wins!"
    else
      puts 'Tie Game! Better luck next round'
    end
    puts '+----------=----------+'
  end

  def next_marker(round)
    markers[round % markers.count]
  end

  def player_move(player)
    if player.class == Human
      player.move(board)
    else
      player.move(board, markers).location
    end
  end

  def play_again?
    puts 'Do you want to play again (y/n)?'
    print '=> '
    gets.chomp.downcase == 'y'
  end

  def initialize_player_scores
    self.scores = {}
    players.each do |player|
      scores[player] = 0
    end
  end

  def display_game_area
    system 'clear' || system('cls')
    display_game_info
    display_game_stats
    display_board
  end

  def display_game_info
    markers_win = board.neighborhood_depth * 2 + 1
    puts '+----------+----------+----------+----------+----------+'
    puts "GAME TYPE: #{game_type}, CONSECUTIVE MARKERS TO WIN: #{markers_win}"
    puts '+----------+----------+----------+----------+----------+'
  end

  def display_game_stats
    puts ''
    print 'PLAYERS'.center(20, ' ')
    print 'SCORES'.center(10, ' ')
    print "\n"
    markers.each do |marker|
      print "#{marker.owner.name} (#{marker.mark})".center(20, ' ')
      print "#{scores[marker.owner]}".center(10, ' ')
      print "\n"
    end
    puts ''
    puts '+----------+----------+----------+----------+----------+'
  end

  def display_board
    puts board.draw
  end

  def setup_players_marker(markers)
    players.each do |player|
      player.choose_marker(markers)
    end
    markers.collection.shuffle!
  end

  def players_setup
    system 'clear' || system('cls')
    puts CONFIG[game_type]['intro']
    puts ''
    puts 'How many human players will play?'
    human_count = human_count_input
    computer_count = CONFIG[game_type]['players'] - human_count
    human_players(human_count) + computer_players(computer_count)
  end

  def human_players(count)
    players = []
    count.times do
      players << Human.new(player_name)
    end
    players
  end

  def computer_players(count)
    players = []
    count.times do
      players << Computer.new
    end
    players
  end

  def player_name
    puts 'Input human player name:'
    print '=> '
    gets.chomp
  end

  def game_selection
    system 'clear' || system('cls')
    puts 'Welcome to the extended version of the classic tic-tac-toe game'
    puts 'Choose a game type before we begin'

    CONFIG['game_types'].each_with_index do |game_type, idx|
      puts "[#{idx}]: #{game_type}"
    end

    game_selection_input
  end

  def game_selection_input
    loop do
      print '=> '
      selection = gets.chomp.to_i
      return CONFIG['game_types'][selection] if valid_selection?(selection)
    end
  end

  def human_count_input
    loop do
      print '=> '
      count = gets.chomp
      return count.to_i if valid_count?(count)
    end
  end

  def valid_count?(count)
    count =~ /\d/ && count.to_i <= CONFIG[game_type]['players']
  end

  def valid_selection?(selection)
    (0..CONFIG['game_types'].count - 1).to_a.include? selection
  end
end

# TTTGame.new.play
