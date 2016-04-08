require 'minitest/autorun'
require_relative 'nth_fibonacci'

class FibonacciTest < Minitest::Test
  def test_zeroth_fibonacci
    assert_equal 0, Fibonacci.nth(0)
  end

  def test_second_fibonacci
    assert_equal 1, Fibonacci.nth(2)
  end

  def test_sixtth_fibonacci
    assert_equal 8, Fibonacci.nth(6)
  end
end
