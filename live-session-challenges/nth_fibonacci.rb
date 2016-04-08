require 'pry'

module Fibonacci
  def self.nth(count)
    fibs = [0, 1]
    return fibs[count] if count < 2

    fibs << next_fib(fibs[-1], fibs[-2]) until fibs.size == count + 1
    fibs.last
  end

  def self.next_fib(fib1, fib2)
    fib1 + fib2
  end
end
