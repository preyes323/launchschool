module Calculator
  def self.add(num1, num2)
    unless numeric_input?(num1, num2)
      input_warning
      return
    end
    Float(num1) + Float(num2)
  end

  def self.subtract(num1, num2)
    unless numeric_input?(num1, num2)
      input_warning
      return
    end
    Float(num1) - Float(num2)
  end

  def self.divide(num1, num2)
    unless numeric_input?(num1, num2)
      input_warning
      return
    end
    Float(num1) / Float(num2)
  end

  def self.multiply(num1, num2)
    unless numeric_input?(num1, num2)
      input_warning
      return
    end
    Float(num1) * Float(num2)
  end

  def self.numeric_input?(num1, num2)
    numeric?(num1) && numeric?(num2)
  end

  def self.numeric?(number)
    Float(number) != nil rescue false
  end

  def self.input_warning
    puts "please input a numeric input"
  end
end
