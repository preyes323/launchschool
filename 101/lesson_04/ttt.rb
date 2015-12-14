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
# Games are race to 5 wins.
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
# 3. Player Markers
# 4. Board Setup
# 5. Game Loop - player moves, board update, winner selection
# 6. Score update
# 7. Winning message
# 8. Play again?

#----------------------------------

require 'colorize'
require 'pry'
require 'yaml'

MESSAGES = YAML.load_file('ttt_messages.yml')
MARKERS = { m1: { marker: '★', color: :blue },
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
    next if player_input_string.length < 4
    if player_input_string.all? { |char| ['-', 'H', 'C'].include? char }
      return player_input_string.keep_if { |char| ['H', 'C'].include? char }
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
                     marker: MARKERS[markers[idx]],
                     name: names[idx] }
  end
  results
end

begin
  display_intro_sequence
  player_types_and_count = input_player_count_types
  player_names = input_player_names(player_types_and_count)
  marker_keys = assign_player_markers(player_types_and_count.length)
  players = build_players(player_types_and_count, marker_keys, player_names)

end
