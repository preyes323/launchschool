# --------------------------------------
# rpssl.rb
# Rock, Paper, Scissors, Spock, and Lizard Game
#
# This is the expanded version of the classic paper, rock, scissors game.
# It adds two more options: lizard and spock.
# Rules are still the same wherein one option choice beats another and
# is defeated by another.
#
# RULES (source: http://www.samkass.com/theories/RPSSL.html)
# Scissors cut Paper covers Rock crushes Lizard poisons Spock smashes
# Scissors decapitates Lizard eats Paper disproves Spock vaporizes
# Rock crushes Scissors
# --------------------------------------

require 'colorize'

CHOICES = { r: '[r]ock', p: '[p]aper', s: '[s]cissors',
            l: '[l]izard', k: 'spoc[k]' }

def msg(msg, color: :default, new_line: true)
  if new_line
    puts msg.colorize(color)
  else
    print msg.colorize(color)
  end
end

def display_welcome_message
  message = %Q(Welcome to the RPSSL game!
This is not your ordinary rock, paper, & scissors game.
PLAY at your own risk!)
  msg(message, color: :light_blue)
end

def player_name
  msg('What is your name brave player?', color: :blue)
  gets.chomp
end

def print_game_header(name, scores)
  header = %Q(+#{'-' * 37}+
+#{' ' * 18}|#{' ' * 18}+
+#{(name + ': ' + scores[0]).center(18, ' ')}|#{('Computer: ' + scores[1]).center(18, ' ')}+
+#{' ' * 18}|#{' ' * 18}+
+#{'-' * 37}+
).chomp
  msg(header)
end

def print_player_area(player_move)
  move = CHOICES[player_move] || ''
  msg(" #{' ' * 18}|#{' ' * 18} ")
  msg(" #{move.center(18, ' ')}|")
  msg(" #{' ' * 18}|#{' ' * 18} ")
end

def player_move_input
  loop do
    msg("Select your move:", color: :blue)
    CHOICES.each { |key, move| msg("#{key}: #{move}", color: :light_blue) }
    msg('=> ', color: :blue, new_line: false)
    move = gets.chomp.to_sym
    return move if CHOICES.keys.include?(move)
  end
end

def display_game_board(name, scores, player_move: nil, computer_move: nil)
  print_game_header(name, scores)
  print_player_area(player_move)
  #print_computer_area(computer_move)
  msg('')
end

loop do
  system 'clear'
  display_welcome_message
  msg('-' * 10, color: :light_blue)
  name = player_name
  scores = [0, 0]
  sleep(3)
  system 'clear'
  display_game_board(name, scores.map(&:to_s))
  move = player_move_input
  display_game_board(name, scores.map(&:to_s), player_move: move)
  break
end
