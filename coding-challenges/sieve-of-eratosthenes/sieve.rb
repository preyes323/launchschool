class Sieve
  attr_reader :prime_candidates

  def initialize(limit = 2)
    @prime_candidates = (2..limit).to_a
  end

  def primes
    prime_numbers = []
    loop do
      prime_numbers << prime_candidates.shift
      prime_candidates.delete_if do |candidate|
        candidate.modulo(prime_numbers[-1]) == 0
      end
      break if prime_candidates.empty?
    end
    prime_numbers
  end
end
