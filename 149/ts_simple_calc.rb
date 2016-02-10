require 'minitest/autorun'
require 'minitest/spec'
require_relative 'simple_oo_calc'

describe Calculator do
  describe '#numeric_input?' do
    it 'must catch that an input was not a number' do
      Calculator.numeric_input?('a', 1).must_be :==, false
    end

    it 'must catch that an input was a number' do
      Calculator.numeric_input?('2', 1).must_be :==, true
    end
  end

  describe '#add' do
    it 'must be able to add number inputs' do
      Calculator.add(1, 2).must_equal 3
    end

    it 'must be able to add string inputs that are numbers' do
      Calculator.add('1', '2').must_equal 3
    end
  end

  describe '#subtract' do
    it 'must be able to subtract number inputs' do
      Calculator.subtract(1, 2).must_equal -1
    end

    it 'must be able to subtract string inputs that are numbers' do
      Calculator.subtract('1', '2').must_equal -1
    end
  end

  describe '#divide' do
    it 'must be able to divide number inputs' do
      Calculator.divide(1, 2).must_equal 0.5
    end

    it 'must be able to divide string inputs that are numbers' do
      Calculator.divide('1', '2').must_equal 0.5
    end
  end

  describe '#multiply' do
    it 'must be able to multiply number inputs' do
      Calculator.multiply(1, 2).must_equal 2
    end

    it 'must be able to multiply string inputs that are numbers' do
      Calculator.multiply('1', '2').must_equal 2
    end
  end
end
