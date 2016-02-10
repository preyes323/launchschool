# Course 120 Notes

#### [Classes and Objects](http://www.rubyfleebie.com/3-steps-to-understand-how-classes-and-objects-work-in-ruby/)

* classes are the blueprints for objects
  * classes provide the defintion of what states and behaviors an object can have and perfrom
  * classes are like factories that churn out objects that can differ based on its states and behaviours
```ruby
new_string_factory = Class.new(String)
my_string = new_string_factory("hello, world!")
puts my_string                 # => hello, world!
my_string.is_a? String         # => true
my_string.instance_of? String  # => true
```
* classes are also objects
  * a look at the #ancestors of class shows that it is derived from an Object class
  * `Class.is_a? Object` `=> true`
* every class defined is an **instance** of a class named Class
  * the class of a class is Class
```ruby
String.instance_of? Class     # => true
String.is_a? Class            # => true
String.instance_of? Object    # => false
String.is_a? Object           # => true

my_string = String.new("Paolo")
my_string.is_a? Object        # => true
my_string.instance_of? Class  # => flase
my_string.instance_of? Object # => false
my_string.is_a? Class         # => false
my_string.is_a? String        # => true
my_string.instance_of? String # => true
```
* every class is an Object
```ruby
Class.ancestors
=> [Class, Module, Object, Kernel, BasicObject]
```
* everyone can modify a class structure
  * since everything is an object, even what `strings` can do can be modified by editing its blueprint; its `class`
```ruby
class String
  def new_method
    puts 'Hello!'
  end
end

'paolo'.new_method  # => 'Hello!'
```
* everything in ruby is an object
  * i.e. : result = 5 + 2
    * 5 is a `Fixnum`
    * + is a method of a `Fixnum`
    * result will become a `Fixnum`

#### Inheritance

*class-based*

* works best when used to model hierarchical domains
* can use `method lookup path` to see order in which Ruby will traverse the class hierarchy to look for methods to invoke.
  * see the lookup path by calling the `#ancestors` method on a class object.

*module-based*

* `Ruby`'s approach to multiple inheritance
* As a rule, ruby can only subclass, from one parent.. however, zero one or more `modules` can be *mix-in* to add additional behavior
```ruby
module Swimmable; end

class Dog < Animal
  include Swimmable
end

class Fish < Animal
  include Swimmable
end
```

#### Collaborator Objects

* These are objects that are assigned to states/instance variables of classes.
* This concept is at the heart of OO programming. It allows to chop up and modularize the problem domain into cohesive pieces
```ruby
class Square; end

class Board
  attr_reader :squares

  def initialize
    squares = []
  end

  def add
    squares << Square.new
  end
end
```

#### Instance vs Class methods

* Class methods belong to the class. It is not tied to any particular single instance
* Instance methods can only be called by a particular instance (object) of the class
```ruby
class SampleClass
  def self.class_method; end

  def instance_method; end
end
```

#### Self

* `self` only has a meaning in the context of a Ruby Class.
* `self` can only be called within an `instance method` or `class method`
* `self` references the calling object
```ruby
class Person
  def existensial_crisis
    self
  end
end

Shane = Person.new('Shane')
s = shane.existensial_crisis    # Shane is the object calling; self is == Shane
Shane.name    # => Shane
s.name        # => Shane
```

#### Truthiness

* everything in Ruby is considered `truthy` except for `false` and `nil`.

#### Fake operators

* one of the thing that ruby provides is syntactical sugar.
  * this allows for operators to look like methods
    * i.e. `+`, `-`, `[]`, etc
    * `Fixnum#+`: increments the value of the argument; returns a **new** integer
    * `String#+`: concatenates the argument; returns a **new** string
    * `Array#+` : concatenates the argument; returns a **new** array
    * `Date#+`  : increments the date in days by value of the argument; returns a **new** date

#### Equivalence

* `==`
  * compares two objects' value
  * to compare custom objects, the `==` method has to be overridden to specify how those objects will be compares
* `equal?`
  * checks whether two variables point to the same object
  * comparing two objects `object_id` is the same as using `equal?`
* `===`
  * used implicitly in `case` statements
* 'eql?`
  * used implicilty by `Hash`