# Object Oriented Programming

1.Explain the relationship between classes and objects. Use code to illustrate your explanation.

  * `classes` are the blueprints objects. It gives a definition of the possible states and behaviours that an object will have and perform.
  * From an analogy point of view, the `class` acts like a car factory that is able to churn out `objects` as cars.
    * With this the act of the factory producing cars is like the instantiation of an `object` from a `class`.
    * The cars when it comes out can have **different** states. For example, a state could be the `number of tires`.
    * The cars likewise can also have **different** behaviours. An example would be the `safety bag trigger` when an accident happens.
  * CODE EXAMPLE
```ruby
class Car
  def initialize(number_of_tires, force_limit = 5)
    @number_of_tires = number_of_tires
    @force_limit = force_limit
  end

  def self.trigger_safety_bag?(force)
    force > @force_limit
  end
end

# Create a new object from the class blueprint
# A blueprint does not mean that every object will be exactly the same
# The state of the object somehow makes each object created different

new_car = Car.new(4)
new_car2 = Car.new(4, 8)

# The two new car objects come from the same class but both are a bit different.
# One car "new_car" triggers the safety bag from less impact as compared to "new_car2".
```
  * Something to note from ruby in its relationship of classes and objects is that all `classes` are `Objects` also.
```ruby
  String.ancestors      # [String, Comparable, Object, Kernel, BasicObject]
  Fixnum.ancestors      # [Fixnum, Integer, Numeric, Comparable, Object, Kernel, BasicObject]
  Class.ancestors       # [Class, Module, Object, Kernel, BasicObject]
```

  * classes are instances of the class `Class`

```ruby
  new_string_factory = Class.new(String)
  my_string = new_string_factory("hello world")
  puts my_string                   # => hello world
  my_string.is_a? String           # => true --> demonstrates that since the String class is an instance, that I can create another instance with a different name that operates the same
```

2.Explain what class inheritance is. Use code to illustrate

  * Class inheritance forms a relationship between classes.
    * This relationship is hierarchical.
    * In ruby a class can only inherit from one class
    * When a class inherits from a class, the class that is inherited from is often called the `super class`
    * The class the inherits gets all the states and behaviours that the `super class` has
``` ruby
  class SuperClass
    def initialize
      @dummy_string = 'Testing testing'
    end

    def print_dummy
      puts @dummy_string
    end
  end

  class InheritingClass < SuperClass
    def print_dummy_again
      puts @dummy_string
    end
  end

  my_class = InheritClass.new

  my_class.print_dummy         # Testing testing --> demonstrates access to behaviours
  my_class.print_dummy_again   # Testing testing --> demonstrates access to state
```

3.How does ruby handle the problem of multiple inheritance? Explain how this modifies the method lookup chain. Use code to illustrate your example

  * Ruby handles multplie inheritance through the use of `modules`.
  * `modules` can be mixed-in to classes
  * When a class `include`s a module it is inserted into the method lookup chain.
  * The last module included will be looked up first
```ruby
  module TestMod1; end
  module TestMod2; end

  class UseModules
    include TestMod1
    include TestMod2
  end

  UseModules.ancestors   # [UseModules, TestMod2, TestMod1, Object, Kernel, BasicObject]
```

4.What's the differece between a class and a module
  * a class can be instantiated but a module can not

5.What's the whole point of Object Oriented Programming? Pros and Cons of OOP?

* PROS
  * It allows us to chop up and modularize the problem into cohesive pieces.
  * The objects can collaborate with each other and have each object be responsible for handling a particular task
    * All the other objects needs to know are what its collaborating objects can do

* CONS
  * Not all objects in the programming point of view is tangible.
    * Non-tangible objects make it a challenge to visualize how an object will be able to address a problem
  * There is a tendency to not have a grasp of the bigger picture. Breaking a problem or code into manageable pieces also means that logic is residing elsewhere. If there is a team working on a code, team members might not grasp easily how they relate and impact each other.

6.What does the phrase "OO Design" mean

* OO design is the planning of how objects will interact and collaborate to address a particular problem or meet an objective.

7.Explain why the last line in the below code outputs "bob". What are two possible ways to fix the change_info method so that it executes correctly?

* The last line did not display the change in name because the `instance method` of `change_info` did not alter the `state` or `instance variable` name. The current implementation of the `change_info` method creates a `local variable` called name which only resides inside the method.

**POSSIBLE CHANGES**
```ruby
def change_info(new_name)
  @name = new_name     # use the instance variable
end
```
```ruby
def change_info(new_name)
  self.name = new_name # use the method generated by the attr_accessor
end
```