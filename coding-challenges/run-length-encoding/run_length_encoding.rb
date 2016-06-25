module RunLengthEncoding
  def self.encode(input)
    input_array = input.chars
    coded = []
    prev_char = input_array.shift
    count = 1

    input_array.each_with_index do |char, idx|
      if char == prev_char
        count += 1
      else
        coded << [prev_char, count]
        count = 1
        prev_char = char
      end

      coded << [char, count] if idx == input_array.length - 1
    end

    code_to_str(coded)
  end

  def self.decode(input)
    input.scan(/\d*[\D]/i).map{ |coded| expand coded }.join
  end

  def self.code_to_str(code)
    code.map{ |key, value| value > 1 ? "#{value}#{key}" : key }.join
  end

  def self.expand(coded)
    count = coded.slice!(/\d+/)
    count ? coded * count.to_i : coded
  end
end
