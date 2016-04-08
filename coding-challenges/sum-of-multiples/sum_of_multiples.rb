class SumOfMultiples
  DEFAULT_NUMBERS = [3, 5]
  @@custom_numbers = nil

  def self.new *numbers
    @@custom_numbers = numbers
    self
  end

  def self.to limit
    numbers = @@custom_numbers || DEFAULT_NUMBERS
    @@custom_numbers = nil

    (1...limit).select do |multiple|
      numbers.any? { |num| multiple % num == 0 }
    end.inject(0, :+)
  end
end
