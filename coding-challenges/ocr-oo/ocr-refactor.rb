require 'pry'
class OCR
  attr_reader :text
  NUMBER_HEIGHT = 4
  NUMBER_WIDTH = 3
               "    _"
  NUMBERS = { " _ | ||_|" => '0',
              "     |  |" => '1',
              " _  _||_ " => '2',
              " _  _| _|" => '3',
              "   |_|  |" => '4',
              " _ |_  _|" => '5',
              " _ |_ |_|" => '6',
              " _   |  |" => '7',
              " _ |_||_|" => '8',
              " _ |_| _|" => '9' }

  def initialize(text)
    @text = text
  end

  def convert
    return parse_single_digit(text) if single_digit?
    return parse_multi_line(text) if multi_line?
    parse_multi_digit(text)
  end

  private

    def single_digit?
      text.split("\n").first.size <= NUMBER_WIDTH
    end

    def multi_line?
      text.match("\n\n")
    end

    def parse_single_digit(digit)
      result = digit.split("\n").map{ |part| standardize(part) }.join
      NUMBERS[result] || '?'
    end

    def parse_multi_digit(digits_in_line)
      parse_digits(digits_in_line)
        .map { |digit| parse_single_digit(digit) }
        .join
    end

    def parse_digits(digits_in_line)
      result = []

      digits_in_line.split("\n").each do |line|
        line.scan(/.{1,#{NUMBER_WIDTH}}/).each_with_index do |part, idx|
          result[idx] ||= ''
          result[idx] << standardize(part)
        end
      end

      result
    end

    def parse_multi_line(lines)
      lines.split("\n\n")
        .map{|line|parse_multi_digit(line)}
        .join(',')
    end

    def standardize(part)
      # binding.pry
      if part == " _"
        part = " _ "
      elsif part == ""
        part = "   "
      elsif part == "|_"
        part = "|_ "
      else
        part
      end
    end
end
