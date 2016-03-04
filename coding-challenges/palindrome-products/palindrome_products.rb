class Palindromes
  attr_reader :min_factor, :max_factor, :palindromes

  def initialize(min_factor: 1, max_factor: nil)
    @min_factor = min_factor
    @max_factor = max_factor
  end

  def generate
    @palindromes = (min_factor..max_factor)
      .to_a
      .repeated_combination(2)
      .to_a
      .keep_if { |num1, num2| palindrome? num1 * num2 }
  end

  def largest
    max_factors = palindromes.max_by { |num1, num2| num1 * num2 }
    max_value = max_factors[0] * max_factors[1]

    all_factors = palindromes.keep_if do |num1, num2|
      num1 * num2 == max_value
    end

    Largest.new(all_factors, max_value)
  end

  def smallest
    min_factors = palindromes.min_by { |num1, num2| num1 * num2 }
    min_value = min_factors[0] * min_factors[1]

    all_factors = palindromes.keep_if do |num1, num2|
      num1 * num2 == min_value
    end

    Smallest.new(all_factors, min_value)
  end

  private

  def palindrome?(number)
    number_reveresed = number.to_s.chars.reverse

    number.to_s.chars.each_with_index.all? do |char, index|
      char == number_reveresed[index]
    end
  end
end

class Palindrome
  attr_reader :factors, :value

  def initialize(factors, value)
    @factors = factors
    @value = value
  end
end

class Largest < Palindrome; end

class Smallest < Palindrome; end
