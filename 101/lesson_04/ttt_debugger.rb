#------------------------------------
# Tic Tac Toe Game
# ttt.rb
#
# This is an extended version of the Tic Tac Toe Game.
# It allows for a bigger size board and additional players.
# There can be a total of 4 players. The board size scales
# with the number of players. This can be a mix of either
# person player or computer player. At minimum there should always
# be 2 players.
#
# There are also standard colored markers depending on the player number.
# Player number is set randomly every start of a new game.
#
# Same rules of the standard tic-tac-toe game apply. 3 in a row wins.
#
# ENJOY!
#
# FYI: All four players can be computer players.
#-----------------------------------

# 1. Intro Sequence / Done
#    1. Welcome Message / Done
#    2.  Instructions / Done
# 2. Number of Players / Done
# 3. Player Markers /  Done
# 4. Board Setup
# 5. Game Loop - player moves, board update, winner selection
# 6. Score update
# 7. Winning message
# 8. Play again?

#----------------------------------

require 'colorize'
require 'pry'
require 'yaml'
require 'io/console'

MESSAGES = YAML.load_file('ttt_messages.yml')
MARKERS = { m1: { marker: '★', color: :magenta },
            m2: { marker: '♥', color: :red },
            m3: { marker: '♣', color: :green },
            m4: { marker: '☀', color: :yellow } }
COMPUTER_NAMES = ['AI_R2D2', 'AI_C3P0', 'AI_Watson', 'AI_Jarvis']


def msg(msg, color: :default, new_line: true)
  if new_line
    puts msg.colorize(color)
  else
    print msg.colorize(color)
  end
end

def display_welcome_message
  msg(MESSAGES['welcome'], color: :blue)
end

def display_instructions
  msg(MESSAGES['instructions'], color: :blue)
  msg('')
  msg('Press enter to start the game!', color: :red)
  gets.chomp
end

def display_intro_sequence
  system 'clear'
  display_welcome_message
  sleep 5
  system 'clear'
  display_instructions
end

def input_player_count_types
  loop do
    system 'clear'
    msg(MESSAGES['player_query'], color: :blue)
    msg('=> ', color: :blue, new_line: false)
    player_input_string = gets.chomp.upcase.chars
    next if player_input_string.length != 4
    if player_input_string.all? { |char| ['-', 'H', 'C'].include? char }
      player_input_string.keep_if { |char| ['H', 'C'].include? char }
      return player_input_string if player_input_string.length > 1
    end
  end
end

def assign_player_markers(player_count)
  MARKERS.keys.slice(0, player_count)
end

def ask_human_name
  system 'clear'
  msg('Name please', color: :blue)
  msg('=> ', color: :blue, new_line: false)
  name = gets.chomp
  name.empty? ? 'NO_NAME' : name
end

def input_player_names(types)
  names = []
  types.length.times do |idx|
    case types[idx]
    when 'H' then names << ask_human_name
    when 'C' then names << COMPUTER_NAMES[idx]
    end
  end
  names
end

def build_players(types, markers, names)
  results = {}
  types.length.times do |idx|
    results[idx] = { type: types[idx],
                     marker: markers[idx],
                     name: names[idx] }
  end
  results
end

def board_size_from_length(board)
  (board.length**0.5).to_i
end

def get_index_from_loc_size(row, col, size)
  col + (row * size)
end

def build_board(player_count)
  size = 3 + (player_count - 2) * 2
  board = {}
  size.times do |row|
    size.times do |col|
      idx = get_index_from_loc_size(row, col, size)
      board[idx] = { location: [row, col],
                     marker: idx.to_s }
    end
  end
  board
end

def draw_marker(marker_idx)
  if MARKERS[marker_idx]
    msg(MARKERS[marker_idx][:marker].center(5, ' '),
        color:  MARKERS[marker_idx][:color],
        new_line: false)
  else
    msg(marker_idx.center(5, ' '), new_line: false)
  end
end

def draw_top_bottom_cell(size)
  size.times do |col|
    if col == size - 1
      msg('+-----+', color: :blue)
    else
      msg('+-----', color: :blue, new_line: false)
    end
  end
end

def draw_padding(size)
  size.times do |col|
    if col == size - 1
      msg('|     |', color: :blue)
    else
      msg('|     ', color: :blue, new_line: false)
    end
  end
end

def draw_middle_cell(row, size, board)
  size.times do |col|
    idx = get_index_from_loc_size(row, col, size)
    marker_idx = board[idx][:marker]
    if col == size - 1
      msg('|', color: :blue, new_line: false)
      draw_marker(marker_idx)
      msg('|', color: :blue)
    else
      msg('|', color: :blue, new_line: false)
      draw_marker(marker_idx)
    end
  end
end

def display_board(board)
  window_row_size, _ = $stdin.winsize
  size = board_size_from_length(board)
  size.times do |row|
    draw_top_bottom_cell(size)
    draw_padding(size) if window_row_size >= 35
    draw_middle_cell(row, size, board)
    draw_padding(size) if window_row_size >= 35
  end
  draw_top_bottom_cell(size)
end

def play_again?
  msg('Play another round? (y/n)', color: :blue)
  msg('=> ', color: :blue, new_line: false)
  gets.chomp.downcase == 'y'
end

def board_empty_squares(board)
  squares = []
  board.values.each do |details|
    squares << details[:marker] if details[:marker] =~ /\A[0-9]+/
  end
  squares
end

def human_move(available_positions, board)
  loop do
    display_board(board)
    msg('Choose a number from the board: ', color: :blue, new_line: false)
    move = gets.chomp
    return move if available_positions.include? move
    system 'clear'
  end
end

def ai_move(available_positions, board)
  display_board(board)
  available_positions.sample
end

def input_player_move(board, player)
  available_positions = board_empty_squares(board)
  if player[:type] == 'H'
    human_move(available_positions, board)
  else
    ai_move(available_positions, board)
  end
end

def update_board!(idx, player, board)
  board[idx.to_i][:marker] = player[:marker]
  system 'clear'
  display_board(board)
  msg("#{player[:name]} put marker on cell #{idx}", color: :blue)
end

def score_upper_left?(loc, mark, board)
  score = 0
  indeces = []
  size = board_size_from_length(board)
  3.times do
    indeces << get_index_from_loc_size(loc[0], loc[1], size)
    loc[0] -= 1
    loc[1] -= 1
    break if loc.flatten.any? { |num| num <= 0 }
  end
  indeces.each { |idx| score += 1 if board[idx][:marker] == mark }
  score
end

def score_top?(loc, mark, board)
  score = 0
  indeces = []
  size = board_size_from_length(board)
  3.times do
    indeces << get_index_from_loc_size(loc[0], loc[1], size)
    loc[0] -= 1
    break if loc.flatten.any? { |num| num <= 0 }
  end
  indeces.each { |idx| score += 1 if board[idx][:marker] == mark }
  score
end

def score_upper_right?(loc, mark, board)
  score = 0
  indeces = []
  size = board_size_from_length(board)
  3.times do
    indeces << get_index_from_loc_size(loc[0], loc[1], size)
    loc[0] -= 1
    loc[1] += 1
    break if loc.flatten.any? { |num| num >= size || num < 0 }
  end
  indeces.each { |idx| score += 1 if board[idx][:marker] == mark }
  score
end

def score_right?(loc, mark, board)
  score = 0
  indeces = []
  size = board_size_from_length(board)
  3.times do
    indeces << get_index_from_loc_size(loc[0], loc[1], size)
    loc[1] += 1
    break if loc.flatten.any? { |num| num >= size }
  end
  indeces.each { |idx| score += 1 if board[idx][:marker] == mark }
  score
end

def score_bottom_right?(loc, mark, board)
  score = 0
  indeces = []
  size = board_size_from_length(board)
  3.times do
    indeces << get_index_from_loc_size(loc[0], loc[1], size)
    loc[0] += 1
    loc[1] += 1
    break if loc.flatten.any? { |num| num >= size }
  end
  indeces.each { |idx| score += 1 if board[idx][:marker] == mark }
  score
end

def score_bottom?(loc, mark, board)
  score = 0
  indeces = []
  size = board_size_from_length(board)
  3.times do
    indeces << get_index_from_loc_size(loc[0], loc[1], size)
    loc[0] += 1
    break if loc.flatten.any? { |num| num >= size }
  end
  ''
  indeces.each { |idx| score += 1 if board[idx][:marker] == mark }
  score
end

def score_bottom_left?(loc, mark, board)
  score = 0
  indeces = []
  size = board_size_from_length(board)
  3.times do
    indeces << get_index_from_loc_size(loc[0], loc[1], size)
    loc[0] += 1
    loc[1] -= 1
    break if loc.flatten.any? { |num| num >= size || num < 0 }
  end
  indeces.each { |idx| score += 1 if board[idx][:marker] == mark }
  score
end

def score_left?(loc, mark, board)
  score = 0
  indeces = []
  size = board_size_from_length(board)
  3.times do
    indeces << get_index_from_loc_size(loc[0], loc[1], size)
    loc[1] -= 1
    break if loc.flatten.any? { |num| num < 0 }
  end
  indeces.each { |idx| score += 1 if board[idx][:marker] == mark }
  score
end

def score_top_bottom?(loc, mark, board)
  score = 0
  size = board_size_from_length(board)
  idx = get_index_from_loc_size(loc[0], loc[1], size)
  score += 1 if board[idx][:marker] == mark

  loc[0] -= 1
  unless loc[0] < 0
    idx = get_index_from_loc_size(loc[0], loc[1], size)
    score += 1 if board[idx][:marker] == mark
  end

  loc[0] += 2
  unless loc[0] >= size
    idx = get_index_from_loc_size(loc[0], loc[1], size)
    score += 1 if board[idx][:marker] == mark
  end

  score
end

def score_left_right?(loc, mark, board)
  score = 0
  size = board_size_from_length(board)
  idx = get_index_from_loc_size(loc[0], loc[1], size)
  score += 1 if board[idx][:marker] == mark

  loc[1] -= 1
  unless loc[1] < 0
    idx = get_index_from_loc_size(loc[0], loc[1], size)
    score += 1 if board[idx][:marker] == mark
  end

  loc[1] += 2
  unless loc[1] >= size
    idx = get_index_from_loc_size(loc[0], loc[1], size)
    score += 1 if board[idx][:marker] == mark
  end

  score
end

def score_top_left_right?(loc, mark, board)
  score = 0
  size = board_size_from_length(board)
  idx = get_index_from_loc_size(loc[0], loc[1], size)
  score += 1 if board[idx][:marker] == mark

  loc[1] -= 1
  loc[0] -= 1
  unless loc.flatten.any? { |num| num < 0 }
    idx = get_index_from_loc_size(loc[0], loc[1], size)
    score += 1 if board[idx][:marker] == mark
  end

  loc[1] += 2
  loc[0] += 2
  unless loc.flatten.any? { |num| num >= size }
    idx = get_index_from_loc_size(loc[0], loc[1], size)
    score += 1 if board[idx][:marker] == mark
  end

  score
end

def score_top_right_left?(loc, mark, board)
  score = 0
  size = board_size_from_length(board)
  idx = get_index_from_loc_size(loc[0], loc[1], size)
  score += 1 if board[idx][:marker] == mark

  loc[1] += 1
  loc[0] -= 1
  unless loc.flatten.any? { |num| num < 0 || num >= size }
    idx = get_index_from_loc_size(loc[0], loc[1], size)
    score += 1 if board[idx][:marker] == mark
  end

  loc[1] -= 2
  loc[0] += 2
  unless loc.flatten.any? { |num| num < 0 || num >= size }
    idx = get_index_from_loc_size(loc[0], loc[1], size)
    score += 1 if board[idx][:marker] == mark
  end

  score
end

SCORE_METHODS = [method(:score_upper_left?), method(:score_top?),
  method(:score_upper_right?), method(:score_right?),
  method(:score_bottom_right?), method(:score_bottom?),
  method(:score_bottom_left?), method(:score_left?),
  method(:score_top_bottom?), method(:score_left_right?),
  method(:score_top_left_right?), method(:score_top_right_left?)]

def player_wins?(moves, mark, board)
  moves.any? do |loc|
    SCORE_METHODS.any? do |method|
      method.call(loc.dup, mark, board) == 3
    end
  end
end

def display_scores(moves, mark, board)
  display_board(board)
  moves.each do |loc|
    msg("#{loc}")
    SCORE_METHODS.each do |method|
      msg("#{method.name}: #{method.call(loc.dup, mark, board)}")
    end
    sleep 15
  end
end

def winner?(board, player)
  player_moves = []
  board.values.each do |details|
    player_moves << details[:location] if details[:marker] == player[:marker]
  end
  display_scores(player_moves, player[:marker], board)
  player_wins?(player_moves, player[:marker], board)
end

def display_winning_board_and_winner(board, winner)
  system 'clear'
  display_board(board)
  if winner
    msg("#{winner[:name]} (#{MARKERS[winner[:marker]][:marker]}) won!")
  else
    msg('TIE GAME!')
  end
  msg('')
end

begin
  #display_intro_sequence

  player_types_and_count = input_player_count_types
  player_names = input_player_names(player_types_and_count)
  marker_keys = assign_player_markers(player_types_and_count.length)

  players = build_players(player_types_and_count, marker_keys, player_names)

  loop do
    system 'clear'
    board = build_board(players.length)
    winner = nil

    loop do
      players.each do |player|
        move = input_player_move(board, player[1])
        update_board!(move, player[1], board)

        sleep 2
        system 'clear'

        winner = player[1] if winner?(board, player[1])
        break if winner || board_empty_squares(board).empty?
      end

      if winner || board_empty_squares(board).empty?
        display_winning_board_and_winner(board, winner)
        break
      end
    end

    break unless play_again?
  end
end
