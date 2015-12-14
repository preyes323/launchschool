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
# 2. Number of Players
# 3. Player types
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
MARKERS = { p1: { marker: '★', color: :blue },
            p2: { marker: '♥', color: :red },
            p3: { marker: '♣', color: :green },
            p4: { marker: '☀', color: :yellow } }

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

def input_player_count
  loop do
    msg(MESSAGES['player_query'], color: :blue)
    msg('=> ', color: :blue, new_line: false)
    player_input_string = gets.chomp
    return player_input_string if player_input_string.chars.all? do |char|
      ['-','H','C'].include? char.upcase
    end
  end
end

begin
  display_intro_sequence
  players = input_player_count
  p players
end
