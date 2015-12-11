# Triplet class is used to test and generate Pythagorean triples that meet
# certain condintions.
class Triplet
  attr_reader :triplet

  def self.where(options = {})
    min = options.fetch(:min_factor, 0)
    max = options.fetch(:max_factor, 99_999)
    sum_value = options.fetch(:sum, nil)

    get_triples(min, max, sum_value)
  end

  def initialize(a, b, c)
    @triplet = [a, b, c]
  end

  def sum
    triplet.reduce(:+)
  end

  def product
    triplet.reduce(:*)
  end

  def pythagorean?
    triplet[0]**2 + triplet[1]**2 == triplet[2]**2
  end

  def self.each_natural
    m = 1
    n = 2
    loop do
      a = n**2 - m**2
      b = 2 * n * m
      c = n**2 + m**2
      yield([a, b, c])
      m += 1
      n += 1
    end
  end

  def self.get_triples(min, max, sum_value)
    result = []
    Triplet.each_natural do |triple|
      break if triple.any? { |factor| factor > max }
      if qualified_triple?(triple, min, sum_value)
        result << Triplet.new(triple[0], triple[1], triple[2])
      end
      result += get_scaled_triples(triple, min, max, sum_value)
    end
    result
  end

  def self.get_scaled_triples(triplet, min, max, sum_value)
    result = []
    mult = 2
    loop do
      triple_scaled = triplet.map { |num| num * mult }
      break if triple_scaled.any? { |factor| factor > max }
      if qualified_triple?(triple_scaled, min, sum_value)
        result << Triplet.new(triple_scaled[0], triple_scaled[1],
                              triple_scaled[2])
      end
      mult += 1
    end
    result
  end

  def self.qualified_triple?(triple, min, sum_value)
    if sum_value
      triple.all? { |factor| factor >= min } && triple.reduce(:+) == sum_value
    else
      triple.all? { |factor| factor >= min }
    end
  end
end
