class Prime
  def self.nth(count)
    raise ArgumentError if count == 0
    primes.take(count).max[0]
  end

  def self.primes
    (2..Float::INFINITY).lazy.with_object([]).select do |num, result|
      if result.empty? || result.all? { |prime_num| num % prime_num != 0 }
        result << num
      else
        false
      end
    end
  end
end
