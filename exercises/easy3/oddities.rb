def oddities(array)
  items = (0...array.size).step(2).map { |index| array[index] }
  require 'pry'; binding.pry
end


p oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
p oddities(['abc', 'def']) == ['abc']
p oddities([123]) == [123]
p oddities([]) == []
