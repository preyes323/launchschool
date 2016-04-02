class Prime
  def self.nth(count)
    raise ArgumentError if count == 0
    primes.take(count).max.first
  end

  def self.primes
    (2..Float::INFINITY).lazy.with_object([]).select do |num, result|
      factors = result.take_while { |factor| factor <= Math.sqrt(num) }

      if result.empty? || factors.all? { |prime_num| num % prime_num != 0 }
        result << num
      else
        false
      end
    end
  end
end
