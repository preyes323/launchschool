require 'pry'

MARKER_INITIAL = ' '
MARKER_PLAYER = 'X'
MARKER_COMPUTER = '0'

def draw_board(position_hash)
  puts ("#{position_hash[1]}#{position_hash[2]}#{position_hash[3]}")
  puts ("#{position_hash[4]}#{position_hash[5]}#{position_hash[6]}")
  puts ("#{position_hash[7]}#{position_hash[8]}#{position_hash[9]}")
  puts ('')
end

def position_hash
  new_board = {}
  (0..9).each { |position| new_board[position] = MARKER_INITIAL}
  new_board
end

def ask_user(game_hash)
  position = ' '
  loop do
    puts("Select a 1~9 position or 'q' to Quit")
    position = gets.chomp
    if position == 'q'
      exit(0)
    else position = position.to_i
      if position > 0 && position < 10 && available_positions!(game_hash).include?(position)
        break
      else
        puts ("INVALID ENTRY.  Choose 1~9 for position or 'q' to Quit")
      end
    end
  end
  position
  # .tap { |x| binding.pry }
end

def available_positions!(game_hash)
  game_hash.keys.select{|position| game_hash[position] == ' '}
  # .tap{|x| binding.pry}
end

def play_user(game_hash, ask_user)
  game_hash[ask_user] = MARKER_PLAYER
  draw_board(game_hash)
  available_positions!(game_hash)
  # .tap{|x| binding.pry}
end

def play_computer(game_hash)
  game_hash[available_positions!(game_hash).sample] = MARKER_COMPUTER
  draw_board(game_hash)
  available_positions!(game_hash)
end

def full(game_hash)
  available_positions!(game_hash).empty?
end

def someone_won(game_hash)
  winning_lines = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  winning_lines.each do |lines|
    if game_hash[lines[0]] == MARKER_PLAYER &&
        game_hash[lines[1]] == MARKER_PLAYER &&
        game_hash[lines[2]] == MARKER_PLAYER
      puts('Player Won!')
      exit(0)
      # return 'Player'
    elsif game_hash[lines[0]] == MARKER_COMPUTER &&
        game_hash[lines[1]] == MARKER_COMPUTER &&
        game_hash[lines[2]] == MARKER_COMPUTER
      puts ('Computer Won!')
      exit(0)
    end
  end
  nil
end

game_hash = position_hash
puts available_positions!(game_hash)
binding.pry
loop do
  draw_board(game_hash)
  play_user(game_hash, ask_user(game_hash))
  break if full(game_hash) || someone_won(game_hash)
  play_computer(game_hash)
  break if full(game_hash) || someone_won(game_hash)
end
draw_board(game_hash)
puts ('Tie game.')
