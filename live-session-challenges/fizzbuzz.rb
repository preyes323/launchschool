class FizzBuzz
  def self.print_fizz_buzz(limit = 100)
    @numbers = (1..limit).to_a
    @numbers.map! do |number|
      if number % 3 == 0 && number % 5 == 0
        'FizzBuzz'
      elsif number % 3 == 0
        'Fizz'
      elsif number % 5 == 0
        'Buzz'
      else
        number
      end
    end
    p @numbers
  end
end

FizzBuzz.print_fizz_buzz(100)
