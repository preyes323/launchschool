require 'colorize'
require 'yaml'
require 'pry'

MESSAGES = YAML.load_file('prs_messages.yml')

module StringTools
  def self.multiline_concatenate(space_allocation, *strings)
    strings.map! { |string| string.split("\n") }
    new_string = put_strings_per_line(strings)
    join_strings_with_space(space_allocation, new_string)
  end

  def self.put_strings_per_line(strings)
    result = []
    strings.each do |lines|
      strings.max_by(&:length).length.times do |index|
        result[index] ||= []
        result[index] << lines[index]
      end
    end
    result
  end

  def self.join_strings_with_space(space_allocation, strings)
    strings.map do |line|
      new_line = ''
      1.upto(line.length - 1) do |idx|
        new_line = join_consecutive_lines(space_allocation,
                                          line[idx - 1], line[idx])
      end
      new_line
    end.join.chomp
  end

  def self.join_consecutive_lines(space_allocation, line1, line2)
    "#{line1}#{' ' * (space_allocation - line1.length)}#{line2}\n"
  end
end

class Player
  attr_reader :name, :move

  def initialize(name = '')
    self.name = name
  end

  def name=(name)
    @name = name.rstrip.empty? ? 'NO_NAME' : name
  end

  def choose; end
end

class Human < Player
  def choose(ratio = nil)
    display_suggested_move(ratio) if ratio

    puts 'Choose a move:'
    puts Weapon.display_options
    @move = Move.new(Weapon.options[player_choice].to_s)
  end

  def display_suggested_move(ratio)
    suggested = ratio.max_by { |_, value| value }
    puts "Suggested move: #{suggested[0]} at #{suggested[1] * 100}%"
  end

  def player_choice
    loop do
      print "=> "
      choice = gets.chomp.to_i
      return choice - 1 if (1..Weapon.options.length).to_a.include? choice
    end
  end
end

class Computer < Player
  NAMES = ['Hal', 'R2D2', 'Deep blue', 'C3P0']

  def initialize
    @name = NAMES.sample
  end

  def choose(choices = nil)
    if choices
      @move = Move.new(choices.sample)
    else
      @move = Move.new(Weapon.options.sample.to_s)
    end
  end
end

class Weapon
  attr_reader :beats, :loses_to

  def self.options
    ObjectSpace.each_object(Class)
      .select { |klass| klass < self }
      .each.sort_by(&:name)
  end

  def self.display_options
    options.map.with_index { |opt, idx| "#{idx + 1}: #{opt}" }.join("\n")
  end

  def name
    "#{self.class}"
  end

  def to_s
    name
  end
end

class Rock < Weapon
  def initialize
    @beats = %w(Scissors Lizard)
    @loses_to = %w(Spock Paper)
  end
end

class Paper < Weapon
  def initialize
    @beats = %w(Rock Spock)
    @loses_to = %w(Lizard Scissors)
  end
end

class Scissors < Weapon
  def initialize
    @beats = %w(Paper Lizard)
    @loses_to = %w(Rock Spock)
  end
end

class Spock < Weapon
  def initialize
    @beats = %w(Rock Scissors)
    @loses_to = %w(Paper Lizard)
  end
end

class Lizard < Weapon
  def initialize
    @beats = %w(Spock Paper)
    @loses_to = %w(Scissors Rock)
  end
end

class Move
  include Comparable
  attr_reader :choice

  def initialize(move)
    move_index = Weapon.options.map(&:to_s).index(move)
    @choice = Weapon.options[move_index].new
  end

  def value
    choice.class
  end

  def to_s
    choice.name
  end

  def <=>(other)
    return 0 if value == other.value

    choice.beats.include?(other.to_s) ? 1 : -1
  end

  def self.winning_message(move1, move2)
    key = if move1 == move2
            'tie'
          else
            "#{Move.new(move1)}_#{Move.new(move2)}".downcase
          end
    MESSAGES[key]
  end
end

module Statisticable
  attr_accessor :scores, :win_history, :data

  def record_move(player, move)
    data[player.class.to_s.to_sym] ||= []
    data[player.class.to_s.to_sym] << move.to_s
  end

  def record_win(winner)
    scores[winner.class.to_s.to_sym] ||= 0
    scores[winner.class.to_s.to_sym] += 1
  end

  def record_move_result(winning_move)
    win_history << winning_move.to_s
  end

  def self.weapons_ratio(move_history)
    compute_ratio(allocate_moves(weapons_choices(move_history)))
  end

  def self.weapons_choices(move_history)
    return nil unless move_history
    move_history.map do |move|
      move_index = Weapon.options.map(&:to_s).index(move)
      Weapon.options[move_index].new.loses_to
    end.flatten.sort
  end

  def self.allocate_moves(moves)
    result = {}
    Weapon.options.each do |weapon|
      result[weapon.name] = moves.select { |move| move == weapon.name }
    end
    result
  end

  def self.compute_ratio(choices)
    total = choices.values.flatten.count
    choices.each { |weapon, use| choices[weapon] = use.count * 1.0 / total }
    choices
  end

  def self.display_move_history(move_history)
    allocate_moves(move_history).to_a.map do |move|
      "#{move[0].center(10, ' ')}| #{display_move_count(move[1])}"
    end.join("\n")
  end

  def self.display_move_count(moves)
    moves.map { |_| '*' }.join
  end
end

class RPSGameDummy
  include Statisticable
  attr_accessor :players

  def initialize
    self.scores = {}
    self.data = {}
    self.win_history = []
  end
end

class RPSGame
  include Statisticable
  attr_accessor :players

  def initialize
    display_welcome_screen
    @computer = Computer.new
    @human = Human.new(player_name)
    self.players = player_order(@human, @computer)
    self.scores = {}
    self.data = {}
    self.win_history = []
  end

  def play
    loop do
      display_game_area(players[0], players[1])

      players_move

      display_game_area(players[0], players[1])

      winner, looser = evalute_player_moves(@human, @computer)
      winner ? process_win(winner, looser) : puts("Tie Game!".colorize(:red))
      sleep 2

      break if stop_playing?
    end
  end

  private

  def process_win(winner, looser)
    record_win(winner)
    record_move_result(winner.move)
    display_winning_message(winner, looser)
  end

  def players_move
    players.each do |player|
      if scores.values.empty?
        record_move(player, player.choose)
      else
        record_move(player, player.choose(opposing_history(player)))
      end
    end
  end

  def opposing_history(player)
    if player.class == Computer
      Statisticable.weapons_choices(data[Human.to_s.to_sym])
    else
      Statisticable.weapons_ratio(data[Computer.to_s.to_sym])
    end
  end

  def display_welcome_screen
    system 'clear' || system('cls')
    puts MESSAGES['welcome']
    puts ''
    sleep 2
  end

  def display_game_area(player1, player2)
    system 'clear' || system('cls')
    display_game_board(player1, player2)
    display_game_move_history(player1, player2)
  end

  def display_game_board(player1, player2)
    player1_info = "#{player1.name}: #{scores[player1.class.to_s.to_sym]}"
    player2_info = "#{player2.name}: #{scores[player2.class.to_s.to_sym]}"
    player1_move = player1.move.to_s
    player2_move = player2.move.to_s
    puts build_board(player1_info, player2_info, player1_move, player2_move)
    puts ''
  end

  def build_board(player1_info, player2_info, player1_move, player2_move)
    %(+-----------------------+-----------------------+
|#{player1_info.center(23, ' ')}|#{player2_info.center(23, ' ')}|
+-----------------------+-----------------------+
|                       |                       |
|#{player1_move.center(23, ' ')}|#{player2_move.center(23, ' ')}|
|                       |                       |
+-----------------------+-----------------------+)
  end

  def display_game_move_history(player1, player2)
    player1_history = data[player1.class.to_s.to_sym]
    player2_history = data[player2.class.to_s.to_sym]
    multiline1 = Statisticable.display_move_history(player1_history || [])
    multiline2 = Statisticable.display_move_history(player2_history || [])
    puts StringTools.multiline_concatenate(25, multiline1, multiline2)
    puts ''
  end

  def display_winning_message(winner, looser)
    puts Move.winning_message(winner.move.to_s,
                              looser.move.to_s).colorize(:red)
    puts ''
  end

  def stop_playing?
    if scores.values.any? { |score| score >= 10 }
      self.scores = {}
      print "Do you want to have another go against #{@computer.name} (y/n)? "
      gets.chomp.downcase == 'n'
    end
  end

  def player_order(*players)
    players.shuffle!
  end

  def player_name
    print "What is your name? "
    gets.chomp
  end

  def evalute_player_moves(player1, player2)
    return [nil, nil] if player1.move == player2.move
    if player1.move > player2.move
      winner = player1
      looser = player2
    else
      winner = player2
      looser = player1
    end
    [winner, looser]
  end
end

RPSGame.new.play

# puts Weapon.options
