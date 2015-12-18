module Swimmable
  def swim
    'swimming'
  end
end

module Fetchable
  def fetch
    'fetching!'
  end
end

class Animal
  def speak;  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end

end

class Cat < Animal
  def speak
    'prrr!'
  end
end

class Dog < Animal
  include Swimmable, Fetchable

  def speak
    'bark!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"
puts teddy.fetch

dexter = Cat.new
puts dexter.speak

p Bulldog.ancestors
