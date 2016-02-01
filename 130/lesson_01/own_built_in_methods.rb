require 'pry'

def times(upper_bound)
  counter = 0

  while counter < upper_bound
    yield(counter)
    counter += 1
  end

  upper_bound
end

# Test implementation
# p times(5) { |num| puts num }

def select(array)
  result = []
  counter = 0

  while counter < array.size
    result << array[counter] if yield(array[counter])
    counter += 1
  end

  result
end

# Test implementation


# p array.select { |num| num.odd? }       # => [1, 3, 5]
# p array.select { |num| puts num }       # => [], because "puts num" returns nil and evaluates to false
# p array.select { |num| num + 1 }

# p select(array) { |num| num.odd? }      # => [1, 3, 5]
# p select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
# p select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true

def reduce(array, default = nil)
  index, acc = default ? [0, default] : [1, array.first]

  while index < array.size
    acc= yield(acc, array[index])
    index += 1
  end

  acc
end

array = [1, 2, 3, 4, 5]
p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
p reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
