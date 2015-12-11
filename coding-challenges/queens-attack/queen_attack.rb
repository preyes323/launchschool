require 'pry'

class Queens
  attr_reader :white, :black

  def initialize(white: [0, 3], black: [7, 3])
    fail ArgumentError, "Queens cannot occupy same space" if white == black
    @white = white
    @black = black
  end

  def to_s
    board = ''
    8.times do |row|
      8.times do |col|
        case [row, col]
        when white then board += 'W '
        when black then board += 'B '
        else board += '_ '
        end
        board[-1] = "\n" if col == 7
      end
    end
    board.chomp
  end

  def attack?
    attack_row? || attack_col? || attack_diag?
  end

  private

  def attack_row?
    white[0] == black[0]
  end

  def attack_col?
    white[1] == black[1]
  end

  def attack_diag?
    (white[0] - black[0]).abs == (white[1] - black[1]).abs
  end

end
