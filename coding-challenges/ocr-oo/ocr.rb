require 'pry'
class OCR
  attr_reader :text, :text_array, :number_count, :number_lines
  attr_accessor :numbers

  NUMBERS_LOOKUP = { '0a' => [" _", "| |", "|_|"],  '1a' => ["", "  |", "  |"],
                     '2a' => [" _", " _|", "|_"],   '3a' => [" _", " _|", " _|"],
                     '4a' => ["", "|_|", "  |"],    '5a' => [" _", "|_", " _|"],
                     '6a' => [" _", "|_", "|_|"],   '7a' => [" _", "  |", "  |"],
                     '8a' => [" _", "|_|", "|_|"],  '9a' => [" _", "|_|", " _|"],
                     '1b' => ["   ", "  |", "  |"], '0b' => [" _ ", "| |", "|_|"],
                     '2b' => [" _ ", " _|", "|_ "], '3b' => [" _ ", " _|", " _|"],
                     '4b' => ["   ", "|_|", "  |"], '5b' => [" _ ", "|_ ", " _|"],
                     '6b' => [" _ ", "|_ ", "|_|"], '7b' => [" _ ", "  |", "  |"],
                     '8b' => [" _ ", "|_|", "|_|"], '9b' => [" _ ", "|_|", " _|"] }
  NUMBER_HEIGHT = 4
  NUMBER_WIDTH = 3

  def initialize(txt)
    @text = txt
    @text_array = text.split("\n").push("")
    self.numbers = []
  end

  def convert
    @number_count = get_count
    @number_lines = get_num_lines
    self.numbers = get_numbers
    string_num = get_string_num
    string_num
  end

  def to_s
    text
  end

  def get_count
    text_array.each do |row|
      return (row.size / Float(NUMBER_WIDTH)).ceil if row.size > 0
    end
  end

  def get_num_lines
    (text_array.size / Float(NUMBER_HEIGHT)).ceil
  end

  def get_numbers
    nums = []
    number_lines.times do |line|
      nums[line] = []
      number_count.times do |number|
        nums[line][number] = []
        row_start = (NUMBER_HEIGHT * line)
        row_end = row_start + 3
        row_start.upto(row_end) do |row|
          num_partial = ''
          pos_start = number * 3
          pos_end = pos_start + 2
          text_array[row].chars.each_with_index do |char, pos|
            num_partial << char if (pos >= pos_start && pos <= pos_end)
          end
          nums[line][number] << num_partial
        end
      end
    end
    nums
  end

  def get_string_num
    num_string = ''
    number_lines.times do |line|
      number_count.times do |number|
        num_string << find_match(line, number)
      end
      num_string << ',' if number_lines > 1 && line < (number_lines - 1)
    end
    num_string
  end

  def find_match(line, number)
    NUMBERS_LOOKUP.each do |key, value|
      match = []
      value.each_with_index do |partial, idx|
        match[idx] = numbers[line][number][idx] == partial ? true : false
      end
      return key[0] if match.all?
    end
    '?'
  end

end
