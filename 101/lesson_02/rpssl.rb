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
require 'pry'

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

def print_moves(player_move, comp_move)
  move = CHOICES[player_move] || ''
  comp_move = CHOICES[comp_move] || ''
  msg(" #{' ' * 18}|#{' ' * 18} ")
  msg(" #{move.center(18, ' ')}|", new_line: false)
  msg(" #{comp_move.center(18, ' ')}")
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

def computer_move_randomizer
  moves = []
  9.upto(50) do
    moves << CHOICES.keys.sample
  end
  moves
end

def display_game_board(name, scores, old_scores: nil,
                                     player_move: nil,
                                     computer_move: [nil])
  computer_move.each_with_index do |comp_move, idx|
    system 'clear'
    if idx == computer_move.length - 1
      print_game_header(name, scores)
    else
      print_game_header(name, old_scores)
    end
    print_moves(player_move, comp_move)
    sleep(0.05)
  end
  msg('')
end

def update_scores!(scores, winner)
  if winner == :player
    scores[0] += 1
  elsif winner == :computer
    scores[1] += 1
  end
end

def game_winner(player_move, computer_move)
  return :tie if player_move == computer_move
  case player_move
  when :s
    if computer_move == :p || computer_move == :l
      :player
    else
      :computer
    end
  when :p
    if computer_move == :r || computer_move == :k
      :player
    else
      :computer
    end
  when :r
    if computer_move == :l || computer_move == :s
      :player
    else
      :computer
    end
  when :l
    if computer_move == :p || computer_move == :k
      :player
    else
      :computer
    end
  when :k
    if computer_move == :s || computer_move == :r
      :player
    else
      :computer
    end
  end
end

def display_winning_message(move1, move2)
  message = case move1
            when :s
              case move2
              when :p then 'Scissors cut Paper!'
              when :l then 'Scissors decapitates Lizard!'
              when :r then 'Rock crushes Scissors!'
              when :k then 'Spock smashes Scissors!'
              end
            when :p
              case move2
              when :r then 'Paper covers Rock!'
              when :k then 'Paper disproves Spock!'
              when :s then 'Scissors cut Paper!'
              when :l then 'Lizard eats Paper!'
              end
            when :r
              case move2
              when :s then 'Rock crushes Scissors!'
              when :l then 'Rock crushes Lizard!'
              when :p then 'Paper covers Rock!'
              when :k then 'Spock vaporizes Rock!'
              end
            when :l
              case move2
              when :k then 'Lizard poisons Spock!'
              when :p then 'Lizard eats Paper!'
              when :s then 'Scissors decapitates Lizard!'
              when :r then 'Rock crushes Lizard!'
              end
            when :k
              case move2
              when :s then 'Spock smashes Scissors!'
              when :r then 'Spock vaporizes Rock!'
              when :l then 'Lizard poisons Spock!'
              when :p then 'Paper disproves Spock!'
              end
            end
  message ||= 'We think alike!!!'
  msg(message.center(39, ' '), color: :light_blue)
  msg(' ')
end

def play_again?
  msg('Play another round? (y/n)', color: :light_blue)
  msg('=> ', color: :blue, new_line: false)
  gets.chomp == 'y'
end

system 'clear'
display_welcome_message
msg('-' * 10, color: :light_blue)
name = player_name
scores = [0, 0]
sleep(2)
system 'clear'

loop do
  display_game_board(name, scores.map(&:to_s))
  move = player_move_input
  comp_moves = computer_move_randomizer
  winner = game_winner(move, comp_moves[-1])
  old_scores = scores.dup
  update_scores!(scores, winner)
  display_game_board(name, scores.map(&:to_s),
                     old_scores: old_scores.map(&:to_s),
                     player_move: move,
                     computer_move: comp_moves)
  display_winning_message(move, comp_moves[-1])
  break unless play_again?
end
